import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

typedef ContextMenuBuilder =
    Widget Function(BuildContext context, Offset offset);

class ContextMenuRegion extends HookWidget {
  final Offset? mobileAnchor;
  final Widget child;
  final ContextMenuBuilder contextMenuBuilder;
  const ContextMenuRegion({
    super.key,
    required this.child,
    required this.contextMenuBuilder,
    this.mobileAnchor,
  });

  @override
  Widget build(BuildContext context) {
    final contextMenuController = useMemoized(() => ContextMenuController());
    final mobileOffset = useState<Offset?>(null);

    bool canBeTouchScreen = switch (defaultTargetPlatform) {
      TargetPlatform.android || TargetPlatform.iOS => true,
      _ => false,
    };

    void showMenu(Offset position) {
      contextMenuController.show(
        context: context,
        contextMenuBuilder: (BuildContext context) {
          return contextMenuBuilder(context, position);
        },
      );
    }

    void hideMenu() {
      contextMenuController.remove();
    }

    void onSecondaryTapUp(TapUpDetails details) {
      showMenu(details.globalPosition);
    }

    void onTap() {
      if (!contextMenuController.isShown) {
        return;
      }
      hideMenu();
    }

    void onLongPressStart(LongPressStartDetails details) {
      mobileOffset.value = details.globalPosition;
    }

    void onLongPress() {
      assert(mobileOffset.value != null);
      showMenu(mobileAnchor ?? mobileOffset.value!);
      mobileOffset.value = null;
    }

    useEffect(() {
      return () {
        hideMenu();
      };
    }, []);

    return TapRegion(
      behavior: HitTestBehavior.opaque,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onSecondaryTapUp: onSecondaryTapUp,
        onTap: onTap,
        onLongPress: canBeTouchScreen ? onLongPress : null,
        onLongPressStart: canBeTouchScreen ? onLongPressStart : null,
        child: child,
      ),
      onTapOutside: (_) {
        hideMenu();
      },
    );
  }
}
