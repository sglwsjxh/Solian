import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:island/route.gr.dart';
import 'package:island/services/responsive.dart';
import 'package:material_symbols_icons/symbols.dart';

@RoutePage()
class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final useHorizontalLayout =
        MediaQuery.of(context).size.width > kWideScreenWidth;

    return AutoTabsRouter.pageView(
      routes: const [
        ExploreRoute(),
        ChatListRoute(),
        RealmListRoute(),
        AccountRoute(),
      ],
      scrollDirection: useHorizontalLayout ? Axis.vertical : Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: tabsRouter.setActiveIndex,
            destinations: [
              NavigationDestination(
                label: 'explore'.tr(),
                icon: const Icon(Symbols.explore),
              ),
              NavigationDestination(
                label: 'chat'.tr(),
                icon: const Icon(Symbols.chat),
              ),
              NavigationDestination(
                label: 'realms'.tr(),
                icon: const Icon(Symbols.workspaces),
              ),
              NavigationDestination(
                label: 'account'.tr(),
                icon: const Icon(Symbols.account_circle),
              ),
            ],
          ),
        );
      },
    );
  }
}
