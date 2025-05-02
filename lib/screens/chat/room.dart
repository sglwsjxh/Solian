import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:island/widgets/content/cloud_files.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:styled_widget/styled_widget.dart';
import 'chat.dart';

@RoutePage()
class ChatRoomScreen extends HookConsumerWidget {
  final int id;
  const ChatRoomScreen({super.key, @PathParam("id") required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatRoom = ref.watch(chatroomProvider(id));

    final messageController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: chatRoom.when(
          data:
              (room) => Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 26,
                    width: 26,
                    child:
                        room?.picture != null
                            ? ProfilePictureWidget(
                              item: room?.picture,
                              fallbackIcon: Symbols.chat,
                            )
                            : CircleAvatar(
                              child: Text(
                                room?.name[0].toUpperCase() ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                  ),
                  Text(room?.name ?? 'unknown').fontSize(19).tr(),
                ],
              ),
          loading: () => const Text('Loading...'),
          error: (_, __) => const Text('Error'),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
          const Gap(8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: chatRoom.when(
              data: (room) => SizedBox.expand(),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
          Material(
            elevation: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(icon: const Icon(Icons.add), onPressed: () {}),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'chatMessageHint'.tr(
                          args: [chatRoom.value?.name ?? 'unknown'.tr()],
                        ),
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      maxLines: null,
                      onTapOutside:
                          (_) => FocusManager.instance.primaryFocus?.unfocus(),
                    ),
                  ),
                  const Gap(8),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {},
                  ),
                ],
              ).padding(bottom: MediaQuery.of(context).padding.bottom),
            ),
          ),
        ],
      ),
    );
  }
}
