import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:island/database/message.dart';
import 'package:island/models/chat.dart';
import 'package:island/screens/chat/room.dart';
import 'package:island/widgets/content/cloud_file_collection.dart';
import 'package:island/widgets/content/cloud_files.dart';
import 'package:island/widgets/content/markdown.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:super_context_menu/super_context_menu.dart';

class MessageItemAction {
  static const String edit = "edit";
  static const String delete = "delete";
  static const String reply = "reply";
  static const String forward = "forward";
}

class MessageItem extends HookConsumerWidget {
  final LocalChatMessage message;
  final bool isCurrentUser;
  final Function(String action)? onAction;
  final Map<int, double>? progress;
  final bool showAvatar;

  const MessageItem({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.onAction,
    required this.progress,
    required this.showAvatar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textColor =
        isCurrentUser
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.onSurfaceVariant;
    final containerColor =
        isCurrentUser
            ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5)
            : Theme.of(context).colorScheme.surfaceContainer;
    final linkColor = Color.alphaBlend(
      Theme.of(context).colorScheme.primary,
      containerColor,
    );

    final remoteMessage = message.toRemoteMessage();
    final sender = remoteMessage.sender;

    return ContextMenuWidget(
      menuProvider: (_) {
        if (onAction == null) return Menu(children: []);
        return Menu(
          children: [
            if (isCurrentUser)
              MenuAction(
                title: 'edit'.tr(),
                image: MenuImage.icon(Symbols.edit),
                callback: () {
                  onAction!.call(MessageItemAction.edit);
                },
              ),
            if (isCurrentUser)
              MenuAction(
                title: 'delete'.tr(),
                image: MenuImage.icon(Symbols.delete),
                callback: () {
                  onAction!.call(MessageItemAction.delete);
                },
              ),
            if (isCurrentUser) MenuSeparator(),
            MenuAction(
              title: 'reply'.tr(),
              image: MenuImage.icon(Symbols.reply),
              callback: () {
                onAction!.call(MessageItemAction.reply);
              },
            ),
            MenuAction(
              title: 'forward'.tr(),
              image: MenuImage.icon(Symbols.forward),
              callback: () {
                onAction!.call(MessageItemAction.forward);
              },
            ),
          ],
        );
      },
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showAvatar) ...[
                Row(
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ProfilePictureWidget(
                      fileId: sender.account.profile.pictureId,
                      radius: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2,
                      children: [
                        Text(
                          DateFormat.Hm().format(message.createdAt.toLocal()),
                          style: TextStyle(fontSize: 10, color: textColor),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 5,
                          children: [
                            Text(
                              sender.account.nick,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Badge(
                              label:
                                  Text(
                                    sender.role >= 100
                                        ? 'permissionOwner'
                                        : sender.role >= 50
                                        ? 'permissionModerator'
                                        : 'permissionMember',
                                  ).tr(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(4),
              ],
              const Gap(2),
              Row(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (remoteMessage.repliedMessageId != null)
                            MessageQuoteWidget(
                              message: message,
                              textColor: textColor,
                              isReply: true,
                            ),
                          if (remoteMessage.forwardedMessageId != null)
                            MessageQuoteWidget(
                              message: message,
                              textColor: textColor,
                              isReply: false,
                            ),
                          if (remoteMessage.content?.isNotEmpty ?? false)
                            MarkdownTextContent(
                              content: remoteMessage.content!,
                              isSelectable: true,
                              linkStyle: TextStyle(color: linkColor),
                              textStyle: TextStyle(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          if (remoteMessage.attachments.isNotEmpty)
                            CloudFileList(
                              files: remoteMessage.attachments,
                              maxWidth: MediaQuery.of(context).size.width * 0.8,
                            ).padding(top: 4),
                          if (progress != null && progress!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 8,
                              children: [
                                if ((remoteMessage.content?.isNotEmpty ??
                                    false))
                                  const Gap(0),
                                for (var entry in progress!.entries)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'fileUploadingProgress'.tr(
                                          args: [
                                            (entry.key + 1).toString(),
                                            entry.value.toStringAsFixed(1),
                                          ],
                                        ),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: textColor.withOpacity(0.8),
                                        ),
                                      ),
                                      const Gap(4),
                                      LinearProgressIndicator(
                                        value: entry.value / 100,
                                        backgroundColor:
                                            Theme.of(
                                              context,
                                            ).colorScheme.surfaceVariant,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                            ),
                                      ),
                                    ],
                                  ),
                                const Gap(0),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  _buildMessageIndicators(
                    context,
                    textColor,
                    remoteMessage,
                    message,
                    isCurrentUser,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageIndicators(
    BuildContext context,
    Color textColor,
    SnChatMessage remoteMessage,
    LocalChatMessage message,
    bool isCurrentUser,
  ) {
    return Row(
      spacing: 4,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (remoteMessage.editedAt != null)
          Text(
            'edited'.tr().toLowerCase(),
            style: TextStyle(fontSize: 11, color: textColor.withOpacity(0.7)),
          ),
        if (isCurrentUser)
          _buildStatusIcon(
            context,
            message.status,
            textColor.withOpacity(0.7),
          ).padding(bottom: 3),
      ],
    );
  }

  Widget _buildStatusIcon(
    BuildContext context,
    MessageStatus status,
    Color textColor,
  ) {
    switch (status) {
      case MessageStatus.pending:
        return Icon(Icons.access_time, size: 12, color: textColor);
      case MessageStatus.sent:
        return Icon(Icons.check, size: 12, color: textColor);
      case MessageStatus.failed:
        return Consumer(
          builder:
              (context, ref, _) => GestureDetector(
                onTap: () {
                  ref
                      .read(messagesNotifierProvider(message.roomId).notifier)
                      .retryMessage(message.id);
                },
                child: const Icon(
                  Icons.error_outline,
                  size: 12,
                  color: Colors.red,
                ),
              ),
        );
    }
  }
}

class MessageQuoteWidget extends HookConsumerWidget {
  final LocalChatMessage message;
  final Color textColor;
  final bool isReply;

  const MessageQuoteWidget({
    super.key,
    required this.message,
    required this.textColor,
    required this.isReply,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesNotifier = ref.watch(
      messagesNotifierProvider(message.roomId).notifier,
    );

    return FutureBuilder<LocalChatMessage?>(
      future: messagesNotifier.fetchMessageById(
        isReply
            ? message.toRemoteMessage().repliedMessageId!
            : message.toRemoteMessage().forwardedMessageId!,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
              color: Theme.of(
                context,
              ).colorScheme.primaryFixedDim.withOpacity(0.4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isReply)
                    Row(
                      spacing: 4,
                      children: [
                        Icon(Symbols.reply, size: 16, color: textColor),
                        Text(
                          'Replying to ${snapshot.data!.toRemoteMessage().sender.account.nick}',
                        ).textColor(textColor).bold(),
                      ],
                    )
                  else
                    Row(
                      spacing: 4,
                      children: [
                        Icon(Symbols.forward, size: 16, color: textColor),
                        Text(
                          'Forwarded from ${snapshot.data!.toRemoteMessage().sender.account.nick}',
                        ).textColor(textColor).bold(),
                      ],
                    ),
                  if (snapshot.data!.toRemoteMessage().content?.isNotEmpty ??
                      false)
                    Text(
                      snapshot.data!.toRemoteMessage().content!,
                      style: TextStyle(color: textColor),
                    ),
                ],
              ),
            ),
          ).padding(bottom: 4);
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
