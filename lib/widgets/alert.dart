import 'package:flutter_platform_alert/flutter_platform_alert.dart';

void showErrorAlert(dynamic err) async {
  FlutterPlatformAlert.showAlert(
    windowTitle: 'Something went wrong...',
    text: err.toString(),
    alertStyle: AlertButtonStyle.ok,
    iconStyle: IconStyle.error,
  );
}
