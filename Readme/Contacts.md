# Usage - Contacts

## 1. Add Embedded Profiles

First you need to add the profiles folder named _SmartCalling_. It should contain one or more .plist file and some images. Just drag and drop the folder into your project structure. Make sure you select "Copy items if needed", "Create folder references" and the target below.

<img src="https://github.com/Smartcalling/SmartCalling-iOS/blob/master/Readme/add_folder.png?raw=true" width="400">

Sample SmartCalling folder can be found in the example project. (SmartCalling-iOS/Example/SmartCalling/SmartCalling)

## 2. Permissions

To add contacts to users device, the app needs permission for Contacts. You need to add a usage description in the Info.plist file for the key _NSContactsUsageDescription_ with a text value.

<img src="https://github.com/Smartcalling/SmartCalling-iOS/blob/master/Readme/permission.png?raw=true" width="400">

The SDK will initally ask for users permission. If the user denies it, SDK will not be able to add profiles.
For a better user experience, the app can check if the user has denied Contacts permission and present a pop-up if so. This logic should be introduced by the app developer.

## 3. Import Framework

To use the SDK you first need to import it. To do that in Swift just add
```swift
import SmartCallingSDK
```
on top of your Swift file.

If you want to use in an Objective-C class, use this import line:
```objective-c
@import SmartCallingSDK;
```

## 4. Import Embedded Profiles (Offline Integration)

To actually use the SDK and import profiles on user devices, use the code below for AppDelegate.

```swift
func applicationDidBecomeActive(_ application: UIApplication) {
    SmartCallingManager.shared().importProfiles { error in
        if let error = error {
            print("SmartCalling Import Profiles Failed: \(error)")
        } else {
            print("SmartCalling Import Profiles Succeeded")
        }
    }
}
```

In this example importProfilesFromEmbeddedPlist function is called within Application Did Become Active event. It can be used in other places but this will make sure to try again in some error cases like when no permission is given. Calling importProfilesFromEmbeddedPlist multiple times has no performance effects, becuase it'll only update the profiles when necessary. This process is asynchronous and won't block the app.

## 5. Update Profiles (Online Integration)

Online integration works just like offline one but you need to set your Api Key first. Everytime you call SDK's updateProfiles function, all the contacts will be updated if there is a change in your remote configuration. If you want to use both offline and online solutions, make sure that you call updateProfiles function on completion of importProfiles function. Otherwise since these 2 functions are asynchronous, they can clash.

Swift:
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    SmartCallingManager.shared().setApiKey("XXXX-XXXX-XXXX-XXXX")	

	return true
}

func applicationDidBecomeActive(_ application: UIApplication) {
	// Check for profile updates everytime app becomes active
    SmartCallingManager.shared().updateProfiles { error in
        if let error = error {
            print("SmartCalling Update Profiles Failed: \(error)")
        } else {
            print("SmartCalling Update Profiles Succeeded")
        }
    }
}
```

## 6. Enable Remote Update (Online Integration)

Remote profile update works with silent push notifications. SmartCalling SDK uses Firebase Cloud Messaging product to register for push notification. Please follow the [iOS setup instructions on Firebase website](https://firebase.google.com/docs/cloud-messaging/ios/client). When you receive FCM Token, subscribe to Smartcalling topic and register the token as shown below:

```swift
func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
    // Update profiles when silent push arrives
    SmartCallingManager.shared().updateProfiles(nil)
}

// Firebase MessagingDelegate    
func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
    // Register to push notification
    messaging.subscribe(toTopic: SmartCallingManager.shared().fcmTopic())
    SmartCallingManager.shared().registerFCMToken(fcmToken, completionHandler: nil)
}
```

You can refer to the Example application code hosted on SmartCalling iOS SDK GitHub page.

