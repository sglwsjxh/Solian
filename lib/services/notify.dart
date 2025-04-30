import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

Future<void> subscribePushNotification(Dio apiClient) async {
  await FirebaseMessaging.instance.requestPermission(
    provisional: true,
    alert: true,
    badge: true,
    sound: true,
  );

  String? deviceToken;
  if (kIsWeb) {
    deviceToken = await FirebaseMessaging.instance.getToken(
      vapidKey:
          "BFN2mkqyeI6oi4d2PAV4pfNyG3Jy0FBEblmmPrjmP0r5lHOPrxrcqLIWhM21R_cicF-j4Xhtr1kyDyDgJYRPLgU",
    );
  } else if (Platform.isAndroid) {
    deviceToken = await FirebaseMessaging.instance.getToken();
  } else if (Platform.isIOS) {
    deviceToken = await FirebaseMessaging.instance.getAPNSToken();
  }

  FirebaseMessaging.instance.onTokenRefresh
      .listen((fcmToken) {
        _putTokenToRemote(apiClient, fcmToken, 1);
      })
      .onError((err) {
        log("Failed to get firebase cloud messaging push token: $err");
      });

  if (deviceToken != null) {
    _putTokenToRemote(
      apiClient,
      deviceToken,
      !kIsWeb && (Platform.isIOS || Platform.isMacOS) ? 0 : 1,
    );
  }
}

Future<void> _putTokenToRemote(
  Dio apiClient,
  String token,
  int provider,
) async {
  await apiClient.put(
    "/notifications/subscription",
    data: {"provider": provider, "device_token": token},
  );
}
