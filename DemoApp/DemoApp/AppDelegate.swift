//
//  AppDelegate.swift
//  DemoApp
//
//  Created by Deniz Adalar on 30/05/2020.
//  Copyright © 2020 Incall Ltd. All rights reserved.
//

import UIKit
import SmartCalling
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Setup Firebase Cloud Messaging
    FirebaseApp.configure()
    Messaging.messaging().delegate = self
    UNUserNotificationCenter.current().delegate = self
    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
    UNUserNotificationCenter.current().requestAuthorization(
      options: authOptions,
      completionHandler: {_, _ in })
    application.registerForRemoteNotifications()

    // Setup SmartCallingManager
    SmartCallingManager.shared.apiKey = "XXXXXX-XXXX-XXXX-XXXX-XXXXXX"
    SmartCallingManager.shared.url = URL(string: "https://portal-uat.smartcom.net")! // Optional
    SmartCallingManager.shared.corporateEmail = "info@smartcom.net"

    // Setup Background Fetch
    application.setMinimumBackgroundFetchInterval(60 * 60)

    return true
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Fetch profiles everytime the application comes into foreground
    SmartCallingManager.shared.updateProfiles { error in
      if let error = error {
        print("SmartCalling Update Profiles Failed: \(error)")
      } else {
        print("SmartCalling Update Profiles Succeeded")
      }
    }
  }

  // Send FCM Token to SmartCalling servers
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    messaging.subscribe(toTopic: "campaign")
    SmartCallingManager.shared.setFCMToken(fcmToken) { error in
      if let error = error {
        print("SmartCalling setFCMToken Failed: \(error)")
      } else {
        print("SmartCalling setFCMToken Succeeded")
      }
    }
  }

  // Receive push notification
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    let isSmartCallingNotification = SmartCallingManager.shared.processRemoteNotification(userInfo: userInfo) { error in
      let result: UIBackgroundFetchResult = error == nil ? .newData : .failed
      completionHandler(result)
    }

    if !isSmartCallingNotification { // Not a SmartCalling notification, check for potential other types.
      completionHandler(.failed)
    }
  }

  // Background Fetch
  func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    SmartCallingManager.shared.updateProfiles { error in
      let result: UIBackgroundFetchResult = error == nil ? .newData : .failed
      completionHandler(result)
    }
  }

}

