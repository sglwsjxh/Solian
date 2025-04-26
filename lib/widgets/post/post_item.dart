import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:island/models/post.dart';
import 'package:island/route.gr.dart';
import 'package:island/widgets/content/cloud_file_collection.dart';
import 'package:island/widgets/content/cloud_files.dart';
import 'package:island/widgets/content/markdown.dart';
import 'package:island/widgets/context_menu.dart';
import 'package:styled_widget/styled_widget.dart';

class PostItem extends StatelessWidget {
  final SnPost item;
  final EdgeInsets? padding;
  final bool isOpenable;
  final Function? onRefresh;
  const PostItem({
    super.key,
    required this.item,
    this.padding,
    this.isOpenable = true,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final renderingPadding =
        padding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 16);

    return ContextMenuRegion(
      contextMenuBuilder: (_, offset) {
        return AdaptiveTextSelectionToolbar.buttonItems(
          anchors: TextSelectionToolbarAnchors(primaryAnchor: offset),
          buttonItems: <ContextMenuButtonItem>[
            ContextMenuButtonItem(
              onPressed: () {
                ContextMenuController.removeAny();
                context.router.push(PostEditRoute(id: item.id)).then((value) {
                  if (value != null) {
                    onRefresh?.call();
                  }
                });
              },
              label: 'edit'.tr(),
            ),
          ],
        );
      },
      child: Padding(
        padding: renderingPadding,
        child: Column(
          spacing: 8,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                ProfilePictureWidget(item: item.publisher.picture),
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.publisher.nick).bold(),
                        if (item.content.isNotEmpty)
                          MarkdownTextContent(content: item.content),
                      ],
                    ),
                    onTap: () {
                      if (isOpenable) {
                        context.router.push(PostDetailRoute(id: item.id));
                      }
                    },
                  ),
                ),
              ],
            ),
            if (item.attachments.isNotEmpty)
              CloudFileList(files: item.attachments),
          ],
        ),
      ),
    );
  }
}
