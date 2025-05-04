import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:island/models/file.dart';
import 'package:island/pods/config.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:styled_widget/styled_widget.dart';

import 'image.dart';
import 'video.dart';

class CloudFileWidget extends ConsumerWidget {
  final SnCloudFile item;
  final BoxFit fit;
  const CloudFileWidget({
    super.key,
    required this.item,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serverUrl = ref.watch(serverUrlProvider);
    final uri = '$serverUrl/files/${item.id}';
    switch (item.mimeType?.split('/').firstOrNull) {
      case "image":
        return AspectRatio(
          aspectRatio: (item.fileMeta?['ratio'] ?? 1).toDouble(),
          child: UniversalImage(uri: uri, blurHash: item.fileMeta?['blur']),
        );
      case "video":
        return AspectRatio(
          aspectRatio: (item.fileMeta?['ratio'] ?? 16 / 9).toDouble(),
          child: UniversalVideo(
            uri: uri,
            aspectRatio: (item.fileMeta?['ratio'] ?? 16 / 9).toDouble(),
          ),
        );
      default:
        return Text('Unable render for ${item.mimeType}');
    }
  }
}

class CloudImageWidget extends ConsumerWidget {
  final String fileId;
  final BoxFit fit;
  final double aspectRatio;
  final String? blurHash;
  const CloudImageWidget({
    super.key,
    required this.fileId,
    this.aspectRatio = 1,
    this.fit = BoxFit.cover,
    this.blurHash,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serverUrl = ref.watch(serverUrlProvider);
    final uri = '$serverUrl/files/$fileId';
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: UniversalImage(uri: uri, blurHash: blurHash),
    );
  }
}

class ProfilePictureWidget extends ConsumerWidget {
  final String? fileId;
  final double radius;
  final IconData? fallbackIcon;
  final Color? fallbackColor;
  const ProfilePictureWidget({
    super.key,
    required this.fileId,
    this.radius = 20,
    this.fallbackIcon,
    this.fallbackColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serverUrl = ref.watch(serverUrlProvider);
    final uri = '$serverUrl/files/$fileId';

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: Container(
        width: radius * 2,
        height: radius * 2,
        color: Theme.of(context).colorScheme.primaryContainer,
        child:
            fileId == null
                ? Icon(
                  fallbackIcon ?? Symbols.account_circle,
                  size: radius,
                  color:
                      fallbackColor ??
                      Theme.of(context).colorScheme.onPrimaryContainer,
                ).center()
                : CachedNetworkImage(imageUrl: uri, fit: BoxFit.cover),
      ),
    );
  }
}
