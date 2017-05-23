//
//  AppDelegate.swift
//  ok2park
//
//  Created by Johan Sveningsson on 2017-04-06.
//  Copyright © 2017 Johan Sveningsson. All rights reserved.
//

import UIKit
import UserNotifications
import SwiftMessages

import Firebase
import FirebaseDatabase

import NotificationCenter

import CoreLocation



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager?
    let gcmMessageIDKey = "gcm.message_id"


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FIRApp.configure()
        FIRDatabase.database().persistenceEnabled = true
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            
            // For iOS 10 data message (sent via FCM)
            FIRMessaging.messaging().remoteMessageDelegate = self
            
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {(accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        
        // [END register_for_notifications]
        // FIRApp.configure()
        
        // [START add_token_refresh_observer]
        // Add observer for InstanceID token refresh callback.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.tokenRefreshNotification),
                                               name: .firInstanceIDTokenRefresh,
                                               object: nil)

        
        return true
    }
    
    
    func scheduleNotification(at date: Date) {
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Påminnelse"
        content.body = "Din parkering löper ut om 15 min."
        content.sound = UNNotificationSound.default()
        
        //let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        let request = UNNotificationRequest(identifier: "alarm-id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        print("dfadsfasfsdafasdfadsf")
        
        print("Print entire notification message for preview:  \(notification)")
        
        let userInfoObject = notification.userInfo! as! [String : String]
        
        // Extract custom parameter value from notification message
        let customParameterValue = userInfoObject["customParameterKey_from"]! as String
        print("Message from sent by \(customParameterValue)")
        
        // Extract message alertBody
        let messageToDisplay = notification.alertBody
        
        // Display message alert body in a alert dialog window
        let alertController = UIAlertController(title: "Notification", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction!) in
            
            print("Ok button tapped");
            
        }
        alertController.addAction(OKAction)
        
        // Present dialog window to user
        window?.rootViewController?.present(alertController, animated: true, completion:nil)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        let state = UIApplication.shared.applicationState
        if state == .active {
            if let aps = userInfo["aps"] as? NSDictionary {
                if let alert = aps["alert"] as? NSDictionary {
                    if let message = alert["body"] as? String {
                        if let title = alert["title"] as? String {
                            //Do stuff
                            DispatchQueue.main.async(execute: {
                                NotificationCenter.default.post(name: Notification.Name(rawValue: "tellTicketsViewControllerToUpdate"), object: nil)
                                let view = MessageView.viewFromNib(layout: .MessageView)
                                var config = SwiftMessages.Config()
                                config.duration = .seconds(seconds: 10)
                                view.configureContent(title: title, body: message)
                                // Show the message.
                                SwiftMessages.show(view: view)
                            })
                        }
                    }
                }
            }
        }

    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    func tokenRefreshNotification(_ notification: Notification) {
        if let refreshedToken = FIRInstanceID.instanceID().token() {
            print("InstanceID token: \(refreshedToken)")
        }
        
        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFcm()
    }
    func connectToFcm() {
        // Won't connect since there is no token
        guard FIRInstanceID.instanceID().token() != nil else {
            return
        }
        
        // Disconnect previous FCM connection if it exists.
        FIRMessaging.messaging().disconnect()
        
        FIRMessaging.messaging().connect { (error) in
            if error != nil {
                print("Unable to connect with FCM. \(error?.localizedDescription ?? "")")
            } else {
                print("Connected to FCM.")
            }
        }
    }
    // [END connect_to_fcm]
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        
        
        // With swizzling disabled you must set the APNs token here.
        FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.sandbox)
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
    
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        
        // Print full message.
        print(userInfo)
        let state = UIApplication.shared.applicationState
        if state == .active {
            if let aps = userInfo["aps"] as? NSDictionary {
                if let alert = aps["alert"] as? String {
                    DispatchQueue.main.async(execute: {
                        // NotificationCenter.default.post(name: Notification.Name(rawValue: "tellTicketsViewControllerToUpdate"), object: nil)
                        let view = MessageView.viewFromNib(layout: .MessageView)
                        var config = SwiftMessages.Config()
                        config.duration = .seconds(seconds: 10)
                        view.configureContent(title: "Parkeringen går snart ut!" , body: alert)
                        // Show the message.
                        SwiftMessages.show(view: view)
                    })

                }
                /* if let alert = aps["alert"] as? NSDictionary {
                    
                    if let message = alert["body"] as? String {
                        if let title = alert["title"] as? String {
                            //Do stuff
                            DispatchQueue.main.async(execute: {
                                NotificationCenter.default.post(name: Notification.Name(rawValue: "tellTicketsViewControllerToUpdate"), object: nil)
                                let view = MessageView.viewFromNib(layout: .MessageView)
                                var config = SwiftMessages.Config()
                                config.duration = .seconds(seconds: 10)
                                view.configureContent(title: title, body: message)
                                // Show the message.
                                SwiftMessages.show(view: view)
                            })
                        }
                    }
                } */
            }else {
                DispatchQueue.main.async(execute: {
                    // NotificationCenter.default.post(name: Notification.Name(rawValue: "tellTicketsViewControllerToUpdate"), object: nil)
                    let view = MessageView.viewFromNib(layout: .MessageView)
                    var config = SwiftMessages.Config()
                    config.duration = .seconds(seconds: 10)
                    view.configureContent(title: "Påminnelse" , body: "Din parkering går ut om 15 min.")
                    // Show the message.
                    SwiftMessages.show(config: config, view: view)
                    SwiftMessages.show(view: view)
                })
            }
        }

        
        // Change this to your preferred presentation option
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        print("JOHANSADSDSADSADASÖDJÖ öläaskdösdlk ösdakf älsadkf löadskf öadsf - - - -- - -")
        
    
        completionHandler()
    }
    
    func registerForPushNotifications(_ application: UIApplication) {
        let notificationSettings = UIUserNotificationSettings(
            types: [.badge, .sound, .alert], categories: nil)
        application.registerUserNotificationSettings(notificationSettings)
        application.registerForRemoteNotifications()
        
        /*if #available(iOS 10.0, *) {
         UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
         if !accepted {
         print("Notification access denied.")
         }
         }
         } else {
         // Fallback on earlier versions
         application.registerForRemoteNotifications()
         }*/
    }

}
// [END ios_10_message_handling]
// [START ios_10_data_message_handling]
extension AppDelegate : FIRMessagingDelegate {
    // Receive data message on iOS 10 devices while app is in the foreground.
    func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
}

