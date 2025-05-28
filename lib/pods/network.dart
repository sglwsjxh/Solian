import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:island/models/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';

final imagePickerProvider = Provider((ref) => ImagePicker());

final userAgentProvider = FutureProvider<String>((ref) async {
  final String platformInfo;
  if (kIsWeb) {
    final deviceInfo = await DeviceInfoPlugin().webBrowserInfo;
    platformInfo = 'Web; ${deviceInfo.vendor}';
  } else if (Platform.isAndroid) {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    platformInfo =
        'Android; ${deviceInfo.brand} ${deviceInfo.model}; ${deviceInfo.id}';
  } else if (Platform.isIOS) {
    final deviceInfo = await DeviceInfoPlugin().iosInfo;
    platformInfo = 'iOS; ${deviceInfo.model}; ${deviceInfo.name}';
  } else if (Platform.isMacOS) {
    final deviceInfo = await DeviceInfoPlugin().macOsInfo;
    platformInfo = 'MacOS; ${deviceInfo.model}; ${deviceInfo.hostName}';
  } else if (Platform.isWindows) {
    final deviceInfo = await DeviceInfoPlugin().windowsInfo;
    platformInfo =
        'Windows NT; ${deviceInfo.productName}; ${deviceInfo.computerName}';
  } else if (Platform.isLinux) {
    final deviceInfo = await DeviceInfoPlugin().linuxInfo;
    platformInfo = 'Linux; ${deviceInfo.prettyName}';
  } else {
    platformInfo = 'Unknown';
  }

  final packageInfo = await PackageInfo.fromPlatform();

  return 'Solian/${packageInfo.version}+${packageInfo.buildNumber} ($platformInfo)';
});

final apiClientProvider = Provider<Dio>((ref) {
  final serverUrl = ref.watch(serverUrlProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: serverUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (
        RequestOptions options,
        RequestInterceptorHandler handler,
      ) async {
        try {
          final token = await getToken(ref.watch(tokenProvider));
          if (token != null) {
            options.headers['Authorization'] = 'AtField $token';
          }
        } catch (err) {
          // ignore
        }

        final userAgent = ref.read(userAgentProvider);
        if (userAgent.value != null) {
          options.headers['User-Agent'] = userAgent.value;
        }
        return handler.next(options);
      },
    ),
  );

  return dio;
});

final tokenProvider = Provider<AppToken?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final tokenString = prefs.getString(kTokenPairStoreKey);
  if (tokenString == null) return null;
  return AppToken.fromJson(jsonDecode(tokenString));
});

// Token refresh functionality removed as per backend changes

Future<String?> getToken(AppToken? token) async {
  return token?.token;
}

Future<void> setToken(SharedPreferences prefs, String token) async {
  final appToken = AppToken(token: token);
  final tokenString = jsonEncode(appToken);
  prefs.setString(kTokenPairStoreKey, tokenString);
}
