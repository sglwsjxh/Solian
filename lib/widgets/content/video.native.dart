import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:island/pods/network.dart';
import 'package:island/widgets/alert.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class UniversalVideo extends ConsumerStatefulWidget {
  final String uri;
  final double aspectRatio;
  const UniversalVideo({
    super.key,
    required this.uri,
    this.aspectRatio = 16 / 9,
  });

  @override
  ConsumerState<UniversalVideo> createState() => _UniversalVideoState();
}

class _UniversalVideoState extends ConsumerState<UniversalVideo> {
  Player? _player;
  VideoController? _videoController;

  void _openVideo() async {
    final url = widget.uri;
    MediaKit.ensureInitialized();

    _player = Player();
    _videoController = VideoController(_player!);

    String? uri;
    final inCacheInfo = await DefaultCacheManager().getFileFromCache(url);
    if (inCacheInfo == null) {
      log('[MediaPlayer] Miss cache: $url');
      final token = await getToken(ref.watch(tokenProvider));
      final fileStream = DefaultCacheManager().getFileStream(
        url,
        headers: {'Authorization': 'Bearer $token'},
        withProgress: true,
      );
      await for (var fileInfo in fileStream) {
        if (fileInfo is FileInfo) {
          uri = fileInfo.file.path;
          break;
        }
      }
    } else {
      uri = inCacheInfo.file.path;
      log('[MediaPlayer] Hit cache: $url');
    }
    if (uri == null) {
      showErrorAlert('Failed to open media... $url');
      return;
    }

    _player!.open(Media(uri), play: false);
  }

  @override
  void initState() {
    super.initState();
    _openVideo();
  }

  @override
  void dispose() {
    super.dispose();
    _player?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_videoController == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Video(
      controller: _videoController!,
      aspectRatio: widget.aspectRatio,
      controls:
          !kIsWeb && (Platform.isAndroid || Platform.isIOS)
              ? MaterialVideoControls
              : MaterialDesktopVideoControls,
    );
  }
}
