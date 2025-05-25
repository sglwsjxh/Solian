import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:island/pods/call.dart';
import 'package:island/route.gr.dart';

/// A floating bar that appears when user is in a call but not on the call screen.
class CallOverlayBar extends HookConsumerWidget {
  const CallOverlayBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callState = ref.watch(callNotifierProvider);
    final callNotifier = ref.read(callNotifierProvider.notifier);
    // Only show if connected and not on the call screen
    if (!callState.isConnected) return const SizedBox.shrink();

    return Positioned(
      left: 16,
      right: 16,
      bottom: 32,
      child: GestureDetector(
        onTap: () {
          if (callNotifier.roomId == null) return;
          context.router.push(CallRoute(roomId: callNotifier.roomId!));
        },
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(24),
          color: Theme.of(context).colorScheme.primary,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.call, color: Colors.white),
                    const SizedBox(width: 12),
                    const Text(
                      'In call',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
