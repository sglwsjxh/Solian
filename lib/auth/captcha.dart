import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CaptchaScreen extends StatelessWidget {
  // DISABLED for self-hosting: captcha bypassed, returns empty token
  static Future<String?> show(BuildContext context) async {
    return '';
  }

  const CaptchaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
