import 'package:livekit_client/livekit_client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:island/pods/network.dart';

part 'call.g.dart';
part 'call.freezed.dart';

@freezed
sealed class CallState with _$CallState {
  const factory CallState({
    required bool isMuted,
    required bool isConnected,
    String? error,
  }) = _CallState;
}

@riverpod
class CallNotifier extends _$CallNotifier {
  Room? _room;
  LocalParticipant? _localParticipant;
  LocalAudioTrack? _localAudioTrack;

  @override
  CallState build() {
    return const CallState(isMuted: false, isConnected: false);
  }

  Future<void> joinRoom(String roomId) async {
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.get('/chat/realtime/$roomId/join');
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        final String endpoint = data['endpoint'];
        final String token = data['token'];
        // Connect to LiveKit
        _room = Room();
        await _room!.connect(endpoint, token);
        _localParticipant = _room!.localParticipant;
        // Create local audio track and publish
        _localAudioTrack = await LocalAudioTrack.create();
        await _localParticipant!.publishAudioTrack(_localAudioTrack!);

        // Listen for connection updates
        _room!.addListener(() {
          state = state.copyWith(
            isConnected: _room!.connectionState == ConnectionState.connected,
          );
        });
        state = state.copyWith(isConnected: true);
      } else {
        state = state.copyWith(error: 'Failed to join room');
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  void toggleMute() {
    final newMuted = !state.isMuted;
    state = state.copyWith(isMuted: newMuted);
    if (_localAudioTrack != null) {
      if (newMuted) {
        _localAudioTrack!.mute();
      } else {
        _localAudioTrack!.unmute();
      }
    }
  }

  Future<void> disconnect() async {
    if (_room != null) {
      await _room!.disconnect();
      state = state.copyWith(isConnected: false);
    }
  }

  void dispose() {
    _localAudioTrack?.dispose();
    _room?.dispose();
  }
}
