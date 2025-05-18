import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:island/route.gr.dart';
import 'package:island/services/responsive.dart';
import 'package:material_symbols_icons/symbols.dart';

@RoutePage()
class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final useHorizontalLayout = isWideScreen(context);
    final useExpandableLayout = isWidestScreen(context);

    final destinations = [
      NavigationDestination(
        label: 'explore'.tr(),
        icon: const Icon(Symbols.explore),
      ),
      NavigationDestination(label: 'chat'.tr(), icon: const Icon(Symbols.chat)),
      NavigationDestination(
        label: 'realms'.tr(),
        icon: const Icon(Symbols.workspaces),
      ),
      NavigationDestination(
        label: 'account'.tr(),
        icon: const Icon(Symbols.account_circle),
      ),
    ];

    final routes = [
      ExploreRoute(),
      ChatListRoute(),
      RealmListRoute(),
      AccountRoute(),
    ];

    return AutoTabsRouter.tabBar(
      routes: routes,
      scrollDirection: useHorizontalLayout ? Axis.vertical : Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);

        // Check if current route is a tab route
        final currentRoute = context.router.topRoute;
        final isTabRoute = routes.any(
          (route) => route.routeName == currentRoute.name,
        );

        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body:
              useHorizontalLayout
                  ? Row(
                    children: [
                      if (isTabRoute)
                        Column(
                          children: [
                            Gap(MediaQuery.of(context).padding.top + 8),
                            if (useExpandableLayout)
                              Expanded(
                                child: NavigationDrawer(
                                  backgroundColor: Colors.transparent,
                                  children: [
                                    for (final destination in destinations)
                                      NavigationDrawerDestination(
                                        label: Text(destination.label),
                                        icon: destination.icon,
                                      ),
                                  ],
                                ),
                              )
                            else
                              Expanded(
                                child: NavigationRail(
                                  selectedIndex: tabsRouter.activeIndex,
                                  onDestinationSelected:
                                      tabsRouter.setActiveIndex,
                                  labelType: NavigationRailLabelType.all,
                                  destinations:
                                      destinations
                                          .map(
                                            (d) => NavigationRailDestination(
                                              icon: d.icon,
                                              label: Text(d.label),
                                            ),
                                          )
                                          .toList(),
                                ),
                              ),
                            Gap(MediaQuery.of(context).padding.bottom + 8),
                          ],
                        ),
                      if (isTabRoute)
                        VerticalDivider(
                          color: Theme.of(context).dividerColor,
                          width: 1 / MediaQuery.of(context).devicePixelRatio,
                        ),
                      Expanded(child: child),
                    ],
                  )
                  : child,
          bottomNavigationBar:
              !useHorizontalLayout && isTabRoute
                  ? NavigationBar(
                    selectedIndex: tabsRouter.activeIndex,
                    onDestinationSelected: tabsRouter.setActiveIndex,
                    destinations: destinations,
                  )
                  : null,
        );
      },
    );
  }
}
