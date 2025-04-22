import 'package:web/web.dart' as web;
import 'package:flutter/material.dart';

class UniversalImage extends StatelessWidget {
  final String uri;
  final String? blurHash;
  const UniversalImage({super.key, required this.uri, this.blurHash});

  @override
  Widget build(BuildContext context) {
    return HtmlElementView.fromTagName(
      tagName: 'img',
      onElementCreated: (element) {
        element as web.HTMLImageElement;
        element.src = uri;
        element.style.width = '100%';
        element.style.height = '100%';
      },
    );
  }
}
