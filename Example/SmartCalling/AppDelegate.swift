//
//  AppDelegate.swift
//  SmartCalling
//
//  Created by dominicthomas on 10/22/2017.
//  Copyright (c) 2017 dominicthomas. All rights reserved.
//

import UIKit
import SmartCallingSDK
import Firebase
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        // Set Api Key
        SmartCallingManager.shared().setApiKey("f47678fa-4a80-4ec4-b229-77e806837870")
        
        // Setup Background App Refresh
        application.setMinimumBackgroundFetchInterval(3600) // every 60 mins

        // If you need to get unique SmartCalling Id to identify this device and installation later
        print("SmartCalling Id: \(SmartCallingManager.shared().getSmartCallingId()!)")
        
        // Firebase Messaging Integration
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
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
//        // Offline integration
//        SmartCallingManager.shared().importProfiles { error in
//            if let error = error {
//                print("SmartCalling Import Profiles Failed: \(error)")
//            } else {
//                print("SmartCalling Import Profiles Succeeded")
//            }
//        }
//
        // Online integration
        SmartCallingManager.shared().updateProfiles({ error in
            if let error = error {
                print("SmartCalling Update Profiles Failed: \(error)")
            } else {
                print("SmartCalling Update Profiles Succeeded")
            }
        })
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        // Update profiles when silent push arrives
        SmartCallingManager.shared().updateProfiles(nil)
    }
    
    // Background App Refresh
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        SmartCallingManager.shared().updateProfiles { error in
            let result = error == nil ? UIBackgroundFetchResult.newData : UIBackgroundFetchResult.failed
            completionHandler(result)
        }
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        // Register to push notification
        messaging.subscribe(toTopic: SmartCallingManager.shared().fcmTopic())
        SmartCallingManager.shared().registerFCMToken(fcmToken, completionHandler: nil)
    }
    
}
