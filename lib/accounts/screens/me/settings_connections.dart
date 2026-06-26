import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:island/shared/widgets/layouts/sheet_scaffold.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:solar_network_sdk/solar_network_sdk.dart';

// Helper function to get provider icon and localized name
Widget getProviderIcon(String provider, {double size = 24, Color? color}) {
  final providerLower = provider.toLowerCase();

  // Check if we have an SVG for this provider
  switch (providerLower) {
    case 'apple':
    case 'microsoft':
    case 'google':
    case 'github':
    case 'discord':
    case 'afdian':
    case 'steam':
      return SvgPicture.asset(
        'assets/images/oidc/$providerLower.svg',
        width: size,
        height: size,
        color: color,
      );
    case 'spotify':
      return Image.asset(
        'assets/images/oidc/spotify.webp',
        width: size,
        height: size,
        color: color,
      );
    default:
      return Icon(Symbols.link, size: size);
  }
}

String getLocalizedProviderName(String provider) {
  switch (provider.toLowerCase()) {
    case 'apple':
      return 'accountConnectionProviderApple'.tr();
    case 'microsoft':
      return 'accountConnectionProviderMicrosoft'.tr();
    case 'google':
      return 'accountConnectionProviderGoogle'.tr();
    case 'github':
      return 'accountConnectionProviderGithub'.tr();
    case 'discord':
      return 'accountConnectionProviderDiscord'.tr();
    case 'afdian':
      return 'accountConnectionProviderAfdian'.tr();
    case 'spotify':
      return 'accountConnectionProviderSpotify'.tr();
    case 'steam':
      return 'accountConnectionProviderSteam'.tr();
    default:
      return provider;
  }
}

// DISABLED for self-hosting: OAuth connection management
class AccountConnectionSheet extends HookConsumerWidget {
  final SnAccountConnection connection;
  const AccountConnectionSheet({super.key, required this.connection});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetScaffold(
      titleText: 'accountConnections'.tr(),
      child: Center(
        child: Text('Connections are disabled for self-hosted instances.'),
      ),
    );
  }
}

// DISABLED for self-hosting: OAuth connection management
class AccountConnectionNewSheet extends HookConsumerWidget {
  const AccountConnectionNewSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetScaffold(
      titleText: 'accountConnectionAdd'.tr(),
      child: Center(
        child: Text('Adding connections is disabled for self-hosted instances.'),
      ),
    );
  }
}

// DISABLED for self-hosting: OAuth connection management
class AccountConnectionsSheet extends HookConsumerWidget {
  const AccountConnectionsSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetScaffold(
      titleText: 'accountConnections'.tr(),
      child: Center(
        child: Text('Connections are disabled for self-hosted instances.'),
      ),
    );
  }
}
