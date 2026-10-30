import UIKit
import Flutter
import CoreSpotlight
import app_links

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // Spotlight index of the unlocked content (AssistantIndexService in Dart).
    if let registrar = registrar(forPlugin: "SpotlightIndex") {
      SpotlightIndex.register(with: registrar)
    }
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // A tapped Spotlight result: its identifier is the item's deep link, which opens through
  // app_links like a tapped link (also on cold start, as app_links keeps the initial link).
  override func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
  ) -> Bool {
    if userActivity.activityType == CSSearchableItemActionType,
      let id = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String,
      let url = URL(string: id)
    {
      AppLinks.shared.handleLink(url: url)
      return true
    }
    return super.application(
      application, continue: userActivity, restorationHandler: restorationHandler)
  }
}
