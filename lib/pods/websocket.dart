import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:island/pods/config.dart';
import 'package:island/pods/network.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'websocket.freezed.dart';

@freezed
class WebSocketState with _$WebSocketState {
  const factory WebSocketState.connected() = _Connected;
  const factory WebSocketState.connecting() = _Connecting;
  const factory WebSocketState.disconnected() = _Disconnected;
  const factory WebSocketState.error(String message) = _Error;
}

final websocketProvider = Provider<WebSocketService>((ref) {
  return WebSocketService();
});

class WebSocketService {
  WebSocketChannel? _channel;
  Stream<dynamic>? _broadcastStream;

  Future<void> connect(String url, String atk) async {
    log('[WebSocket] Trying connecting to $url');
    try {
      _channel = IOWebSocketChannel.connect(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $atk'},
      );
      await _channel!.ready;
      _broadcastStream = _channel!.stream.asBroadcastStream();
    } catch (err) {
      log('[WebSocket] Failed to connect: $err');
    }
  }

  WebSocketChannel? get ws => _channel;
  Stream<dynamic> get stream => _broadcastStream!;

  void sendMessage(String message) {
    _channel!.sink.add(message);
  }

  void close() {
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
