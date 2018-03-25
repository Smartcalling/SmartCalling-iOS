//
//  AppDelegate.swift
//  SmartCalling
//
//  Created by dominicthomas on 10/22/2017.
//  Copyright (c) 2017 dominicthomas. All rights reserved.
//

import UIKit
import SmartCallingSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Set Api Key
        SmartCallingManager.shared().setApiKey("XXXX-XXXX-XXXX-XXXX")

        // Offline integration
        SmartCallingManager.shared().importProfiles { error in
            if let error = error {
                print("SmartCalling Import Profiles Failed: \(error)")
            } else {
                print("SmartCalling Import Profiles Succeeded")
            }
        }

        // Online integration
        SmartCallingManager.shared().updateProfiles({ error in
            if let error = error {
                print("SmartCalling Import Profiles Failed: \(error)")
            } else {
                print("SmartCalling Import Profiles Succeeded")
            }
        })
    }

}
