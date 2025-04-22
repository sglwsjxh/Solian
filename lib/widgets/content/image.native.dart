import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class UniversalImage extends StatelessWidget {
  final String uri;
  final String? blurHash;
  final BoxFit fit;
  const UniversalImage({
    super.key,
    required this.uri,
    this.blurHash,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (blurHash != null) BlurHash(hash: blurHash!),
        CachedNetworkImage(imageUrl: uri, fit: fit),
      ],
    );
  }
}
