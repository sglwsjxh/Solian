import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:island/pods/config.dart';
import 'package:island/pods/network.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'websocket.freezed.dart';
part 'websocket.g.dart';

@freezed
class WebSocketState with _$WebSocketState {
  const factory WebSocketState.connected() = _Connected;
  const factory WebSocketState.connecting() = _Connecting;
  const factory WebSocketState.disconnected() = _Disconnected;
  const factory WebSocketState.error(String message) = _Error;
}

@freezed
abstract class WebSocketPacket with _$WebSocketPacket {
  const factory WebSocketPacket({
    required String type,
    required Map<String, dynamic>? data,
    required String? errorMessage,
  }) = _WebSocketPacket;

  factory WebSocketPacket.fromJson(Map<String, dynamic> json) =>
      _$WebSocketPacketFromJson(json);
}

final websocketProvider = Provider<WebSocketService>((ref) {
  return WebSocketService();
});

class WebSocketService {
  WebSocketChannel? _channel;
  final StreamController<WebSocketPacket> _streamController =
      StreamController<WebSocketPacket>.broadcast();
  String? _lastUrl;
  String? _lastAtk;
  Timer? _reconnectTimer;

  Stream<WebSocketPacket> get dataStream => _streamController.stream;

  Future<void> connect(String url, String atk) async {
    _lastUrl = url;
    _lastAtk = atk;
    log('[WebSocket] Trying connecting to $url');
    try {
      _channel = IOWebSocketChannel.connect(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $atk'},
      );
      await _channel!.ready;
      _channel!.stream.listen(
        (data) {
          final dataStr =
              data is Uint8List ? utf8.decode(data) : data.toString();
          final packet = WebSocketPacket.fromJson(jsonDecode(dataStr));
          _streamController.sink.add(packet);
          log("[WebSocket] Received packet: ${packet.type}");
        },
        onDone: () {
          log('[WebSocket] Connection closed, attempting to reconnect...');
          _scheduleReconnect();
        },
        onError: (error) {
          log('[WebSocket] Error occurred: $error, attempting to reconnect...');
          _scheduleReconnect();
        },
      );
    } catch (err) {
      log('[WebSocket] Failed to connect: $err');
      _scheduleReconnect();
    }
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(milliseconds: 500), () {
      if (_lastUrl != null && _lastAtk != null) {
        connect(_lastUrl!, _lastAtk!);
      }
    });
  }

  WebSocketChannel? get ws => _channel;

  void sendMessage(String message) {
    _channel!.sink.add(message);
  }

  void close() {
    _reconnectTimer?.cancel();
    _lastUrl = null;
    _lastAtk = null;
    _channel?.sink.close();
  }
}

final websocketStateProvider =
    StateNotifierProvider<WebSocketStateNotifier, WebSocketState>(
      (ref) => WebSocketStateNotifier(ref),
    );

class WebSocketStateNotifier extends StateNotifier<WebSocketState> {
  final Ref ref;

  WebSocketStateNotifier(this.ref) : super(const WebSocketState.disconnected());

  Future<void> connect() async {
    state = const WebSocketState.connecting();
    try {
      final service = ref.read(websocketProvider);
      final baseUrl = ref.watch(serverUrlProvider);
      final atk = await getFreshAtk(
        ref.watch(tokenPairProvider),
        baseUrl,
        onRefreshed: (atk, rtk) {
          setTokenPair(ref.watch(sharedPreferencesProvider), atk, rtk);
          ref.invalidate(tokenPairProvider);
        },
      );
      if (atk == null) {
        state = const WebSocketState.error('Unauthorized');
        return;
      }
      await service.connect('$baseUrl/ws'.replaceFirst('http', 'ws'), atk);
      state = const WebSocketState.connected();
    } catch (err) {
      state = WebSocketState.error('Failed to connect: $err');
    }
  }

  void sendMessage(String message) {
    final service = ref.read(websocketProvider);
    service.sendMessage(message);
  }

  void close() {
    final service = ref.read(websocketProvider);
    service.close();
    state = const WebSocketState.disconnected();
  }
}
