import UIKit
import Flutter
import Firebase


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
//    FirebaseApp.configure()
    if FirebaseApp.app() == nil {
        FirebaseApp.configure()
    }
    registerForPushNotifications()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
          (granted, error) in
          print("Permission granted: \(granted)")
          UNUserNotificationCenter.current().delegate = self
          guard granted else { return }
          self.getNotificationSettings()
           
        }
      }
    func getNotificationSettings() {
        //    UNUserNotificationCenter.current().getNotificationSettings { (settings) in
        //      print("Notification settings: \(settings)")
        //      guard settings.authorizationStatus == .authorized else { return }
        //      UIApplication.shared.registerForRemoteNotifications()
        //    }
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self
            
          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          UIApplication.shared.registerUserNotificationSettings(settings)
        }
         
        UIApplication.shared.registerForRemoteNotifications()
      }
    private func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
         
        print("Recived: \(userInfo)")
         
         
         
      }

}

