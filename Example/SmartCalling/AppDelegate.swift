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
        SmartCallingManager.shared().setApiKey("1dc877e9-b5b2-44d3-adbb-5347fa9f5e11")

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
