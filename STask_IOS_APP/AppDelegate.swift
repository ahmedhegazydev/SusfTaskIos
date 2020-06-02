//
//  AppDelegate.swift
//  ImageSlider
//
//  Created by Eslam Shaker  on 12/6/18.
//  Copyright © 2018 Eslam Shaker . All rights reserved.
//

import Firebase
//import FirebaseFirestore
import FirebaseMessaging
import UIKit
import UserNotifications
import MOLH
import SSCustomTabbar
import SwiftyJSON


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MOLHResetable {
    
    
    
    var window: UIWindow?
    let gcmMessageIDKey = ""
    var fcmToken: String = ""
    var userInfo: [AnyHashable: Any]? = [:]
    var remoteMessage: MessagingRemoteMessage? = nil
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        UserDefaults.standard.setValue("ar", forKey: Constants.SELECTED_LANG)

        //        let pushManager = PushNotificationManager(userID: "currently_logged_in_user_id")
        //        pushManager.registerForPushNotifications()
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
            application.registerUserNotificationSettings(settings)
        }
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true
        application.registerForRemoteNotifications()
        
        
        
        
        //language
        //        MOLHFont.shared.english = UIFont(name: "Courier", size: 13)!
        //        MOLHLanguage.setDefaultLanguage("ar")
        //        MOLHLanguage.setDefaultLanguage("he")
//                MOLH.shared.activate(true)
        //        MOLH.shared.specialKeyWords = ["Cancel","Done"]
        //        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        //        MOLH.reset()
        
        
        return true
    }
    
    func reset() {
        
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        self.userInfo = userInfo
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        //        // Print message ID.
        //        if let messageID = userInfo[gcmMessageIDKey] {
        //            print("Message ID: \(messageID)")
        //        }
        // Print full message.
        print(userInfo)
        
        switch UIApplication.shared.applicationState {
        case .active:
            //app is currently active, can update badges count here
            break
        case .inactive:
            //app is transitioning from background to foreground (user taps notification), do what you need when user taps here
            break
        case .background:
            //app is in background, if content-available key of your notification is set to 1, poll to your backend to retrieve data and update your interface here
            break
        default:
            break
        }
        
        if let data = userInfo["data"] as? NSDictionary {
            if let byName = data["alert"] as? String {}
            if let content = data["content"] as? String {}
            if let boardId = data["boardId"] as? String {
                if !boardId.isEmpty{
//                    let storyboard = UIStoryboard(name: "Board", bundle: nil)
//                    let homeVc = storyboard.instantiateViewController(withIdentifier: "HomePage") as! SSCustomTabBarViewController
//                    //UserDefaults.standard.setValue(Constants.DATA_BOARD_ID, forKey: boardId)
//                    self.window?.rootViewController = homeVc
                    
                }
            }
        }
        
        let storyboard = UIStoryboard(name: "Board", bundle: nil)
        let homeVc = storyboard.instantiateViewController(withIdentifier: "HomePage") as! SSCustomTabBarViewController
        //UserDefaults.standard.setValue(Constants.DATA_BOARD_ID, forKey: boardId)
        self.window?.rootViewController = homeVc
        
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @ escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate{
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token1: \(fcmToken)")
        
        //saving for passing it to login api
        //        let userDefaults = UserDefaults.standard
        //        userDefaults.setValue(Constants.FCM_TOKEN, forKey: fcmToken)
        
        self.fcmToken = fcmToken
        
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Message data = \(remoteMessage.appData)")
        
        
//        let d : [String : Any] = remoteMessage.appData["notification"] as! [String : Any]
//        let body : String = d["body"] as! String
//        let title : String = d["title"] as! String
//        self.remoteMessage =  remoteMessage
        
        
    }
    
}
