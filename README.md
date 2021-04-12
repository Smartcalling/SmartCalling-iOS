# SmartCalling iOS SDK

The SmartCalling SDK let's you add your company contact details to the iOS AddressBook. In this way users of your app will see a personalised screen when they receive a call from your company.

Please report any bugs/issues/suggestions to cj@smartcalling.co.uk

## Code-Level Documentation

Please refer to the [code-level documentation](Readme/docs/Home.md) for further information. 

## Installation
This library requires IOS version 12 as a minimum.

### Cocoapods

SmartCallingSDK is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

`pod 'SmartCallingSDK'`

Make sure you run `pod install` from command line. Note that this technique requires Cocoapods 1.9 and above. 

### Manual Installation

The SmartCalling.xcframework has been included in this repository. You can drag and drop the file directly to your Xcode project. Make sure that it is visible in your project settings as Embed & Sign.

## Project Setup

To add contacts to users device, the app needs permission for accessing Contacts. You need to add a usage description in the `Info.plist` file for the key `NSContactsUsageDescription` with a text value.

<img src="https://github.com/Smartcalling/SmartCalling-iOS/blob/master/Readme/permission.png?raw=true" width="400">

The SDK will initally ask for users permission. If the user denies it, the SDK will not be able to add profiles and return an error. For a better user experience, the app can check if the user has denied Contacts permission and present a pop-up if so. This logic should be introduced by the app developer.

## Usage

1. In order to use the framework it needs to be imported first. It's pretty straightforward in Swift:
```swift
import SmartCalling
```

2. If you haven't already, you will need to add your app to the SmartCom portal. Once this is done, you will be provided with an API Key. Before using any other functions of the SDK, the API Key needs to be set. The SDK uses general SmartCalling servers (https://portal.smartcom.net) by default. If you need to use a custom server, just override the value as shown below:
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
  SmartCallingManager.shared.apiKey = "XXXX-XXXX-XXXX-XXXX"
  SmartCallingManager.shared.url = URL(string: "https://portal.url")!

  return true
}
```

3. Everytime you call SDK's updateProfiles function, all the contacts will be updated if there is a change in your remote configuration. For example 'applicationDidBecomeActive' might be a good place to update profiles. If you are using a Scene Delegate you will need to add this code to your 'sceneDidBecomeActive' function instead.
```swift
func applicationDidBecomeActive(_ application: UIApplication) {
  // Check for profile updates everytime app becomes active
  SmartCallingManager.shared.updateProfiles { error in
    if let error = error {
      print("SmartCalling Update Profiles Failed: \(error)")
    } else {
      print("SmartCalling Update Profiles Succeeded")
    }
  }
}
```
4. An assumption is made that your app will have a login process that results in the app receiving user information. For the SDK to work completely, your login process must return a unique ID for the user logged in. This unique ID must be passed to the SDK using the following code (where XXX is the unique user ID):
```swift
func loginSucessful(_ userInfo: UserInfo) { // Hypothetical function defined in the app which is called after a successful login.  
  SmartCallingManager.shared.setClienId("XXX") { error in
    if let error = error {
      print("SmartCalling setClientId Failed: \(error)")
    } else {
      print("SmartCalling setClientId Succeeded")
    }
  }
}
```
The SDK will automatically update profiles for the given client ID, so no need to call updateProfiles separately.

## Enable Remote Update

Remote profile update works with silent push notifications. SmartCalling SDK uses Firebase Cloud Messaging to register for push notification. Please follow the [iOS setup instructions on Firebase website](https://firebase.google.com/docs/cloud-messaging/ios/client). When you receive the FCM Token, subscribe to Smartcalling topics and register the token then direct didReceiveRemoteNotification calls to SmartCallingManager's processRemoteNotification function as shown below:

```swift
func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
  // Update profiles when silent push arrives
  let isSmartCallingNotification = SmartCallingManager.shared.processRemoteNotification(userInfo: userInfo) { error in
    let result: UIBackgroundFetchResult = error == nil ? .newData : .failed
    completionHandler(result)
  }

  if !isSmartCallingNotification { // Not a SmartCalling notification, check for potential other types.
    completionHandler(.failed)
  }
}

// Firebase MessagingDelegate    
func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
  // Register to push notification
  messaging.subscribe(toTopic: "smartcallingcampaign")
  messaging.subscribe(toTopic: "smblacklistupdate")
  SmartCallingManager.shared.setFCMToken(fcmToken) { error in
    // Some additional logic for error case
  }
}
```

You can refer to the Example application code hosted on SmartCalling iOS SDK GitHub page.

## Background App Refresh

This native iOS feature can be used to trigger synchronization of SmartCalling contacts even if the application is in the background. Please first follow [this Apple Documentation](https://developer.apple.com/documentation/uikit/core_app/managing_your_app_s_life_cycle/preparing_your_app_to_run_in_the_background/updating_your_app_with_background_app_refresh) page to setup background refresh for your application. After that all you need to do is to start the SmartCalling update process as shown below:

```swift
func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
  SmartCallingManager.shared.updateProfiles { error in
    let result: UIBackgroundFetchResult = error == nil ? .newData : .failed
    completionHandler(result)
  }
}
```
## Anti-Vishing (with CallKit extension)

In order to activate SmartCalling Anti-Vishing feature, you first need to create a Call Directory Extension.

<img src="https://github.com/Smartcalling/SmartCalling-iOS/blob/master/Readme/callkit.png?raw=true" width="400">

If you are using Cocoapods to install the SDK, please make sure the SmartCallingSDK pod is added for the new extension target. If you're manually installing the framework, make sure that it is visible in your project settings as Do Not Embed (not Embed & Sign).

Open CallDirectoryHandler.swift file and import SmartCalling. Mark the class as a subclass of `SmartCallingCallDirectoryHandler` to inherit all required behaviour. You'll need to override `apiKey` (and `url` if you are using a custom SmartCalling backend). The final file should look like this: 

```swift
import Foundation
import SmartCalling

class CallDirectoryHandler: SmartCallingCallDirectoryHandler {
//  // Uncomment this line if you are using a custom SmartCalling server
//  override var url: URL {
//    get { URL(string: "https://portal.smartcom.net")! }
//    set {}
//  }

  override var apiKey: String? {
    get { "XXXXXX-XXXX-XXXX-XXXX-XXXXXX" }
    set {}
  }
}
```
