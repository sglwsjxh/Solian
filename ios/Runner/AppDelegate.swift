import Flutter
import UIKit

import shared_preferences_foundation

@main
@objc class AppDelegate: FlutterAppDelegate {
    let notifyDelegate = NotifyDelegate()
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = notifyDelegate
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
