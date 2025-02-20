import UIKit
import Flutter
import Firebase
import AppTrackingTransparency

import Firebase
import FirebaseMessaging
import UserNotifications
@main
@objc class AppDelegate: FlutterAppDelegate {
    var firebaseToken : String = "";
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    Messaging.messaging().delegate = self;
    FirebaseApp.configure()
    Messaging.messaging().isAutoInitEnabled = true;
    self.registerForFirebaseNotification(application: application);
    GeneratedPluginRegistrant.register(with: self)
    return true;
  }
    
   override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken : Data){
     print("X__APNS: \(String(describing: deviceToken))")
     Messaging.messaging().apnsToken = deviceToken;
     //Messaging.messaging().setAPNSToken(deviceToken, type:MessagingAPNSTokenType.prod )
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print(fcmToken)
    }
    
    override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("X_ERR",error);
    }
    
     func registerForFirebaseNotification(application : UIApplication){
        Messaging.messaging().delegate     = self;
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self ;
            let authOpt : UNAuthorizationOptions = [.alert, .badge, .sound];
            UNUserNotificationCenter.current().requestAuthorization(options: authOpt, completionHandler: {_, _ in})
            UNUserNotificationCenter.current().delegate = self ;
        }else{
            let settings : UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings);
        }
        application.registerForRemoteNotifications();
    }
}

extension AppDelegate : MessagingDelegate{
    func messaging(_messagin : Messaging, didRecieveRegistrationToken fcmToken : String){
        self.firebaseToken = fcmToken;
        print("X__FCM: \(String(describing: fcmToken))")
    }
    func messaging(_messagin : Messaging, didRecieve remoteMessage : Any){
        //self.firebaseToken = fcmToken;
        print("REMOTE__MSG: \(remoteMessage)")
    }
    func application(_ application : UIApplication,didRecieveRemoteNotification uinfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void){
        print("WITH__APN: \(uinfo)")
    }
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        if #available(iOS 14, *) {
            DispatchQueue.main.async {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .authorized:
                        print("enable tracking")
                    case .denied:
                        print("disable tracking")
                    default:
                        print("disable tracking")
                    }
                }
            }
        }
    }
}
