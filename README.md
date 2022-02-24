
# SmartCalling iOS Library

The SmartCalling library let's you add your company contact details to the iOS AddressBook. In this way users of your app will see a personalised screen when they receive a call from your company.

If you plan to use the SmartCalling Demo app for reference please remember to use your command line app to run `pod install` while in the demo app project folder after you have downloaded the code.

Please report any bugs/issues/suggestions through Freshdesk, details to register provided below.

## Pre-Requisites

First you must setup an Account, an App and a Campaign in the portal. The UAT portal address is: https://portal-uat.smartcom.net/

The next step is to add an app into the portal. If you do not already have an app you will need to create your own test app. Once you have an app, you will need to log into the portal and use the Add App button. Make sure you provide all the required details correctly, especially the bundle name. For the IOS package name just enter any value if you do not have an IOS app. The library works much better if you can include the FireBase Push Messaging details so you may need to create a Firebase account for your test app. To find your FCM Key and Sender ID, login to your Firebase account, select your app and then press the Settings button next to the Project Overview label. Then select Cloud Messaging and you will see your Server Key and Sender Id there. If you do not have a server key you will need to add one.

Once the app has been created in the portal, you can then go to the Account section in the portal (Menu - Account) to see and copy your API Key. You will need this key when integrating the library into your app.

You are now ready to follow the instructions below. Simply follow the instructions to reference the library in your app and provide the library with the details it requires. One important part is the ClientId, your app must provide a unique ClientId in your app for each device/user and you must use these clientIds when creating Campaigns.

## Emulators

While you can test the SmartCalling library in an emulator we have noticed some occasional spurious results when testing campaigns and anti-vishing. For that reason, we strongly recommend you test the SmartCalling libraries on physical devices for best results.

## Permissions

The IOS library requires two permissions<br/>
- **Contact Permissions**<br/>
  SmartCalling primarily needs contacts permission in order to function because the SDK adds to and removes from the users address book.

- **Push Notification Permission**<br/>
  The push campaigns feature additionally needs push notification permission and the contacts are managed on the client side triggered by a silent push notification.

## Installation

This library requires IOS version 12 as a minimum.

### Swift Package

This is the recommended method for adding the SmartCalling library into your app. Please follow these instructions to add the SmartCalling library (these instructions are correct as of XCode version 13.2.1):

1. In XCode, select your project in the project explore, then select the project in the settings area and then select the 'Package Dependencies' option. Now, click the + button to add a new package.

<p align="center"><img src="./Readme/images/ios-sp-001.png?raw=true" width="800"></p>

2. Enter the SmartCalling repository address (https://github.com/Smartcalling/SmartCalling-iOS.git) into the search field.

<p align="center"><img src="./Readme/images/ios-sp-002.png?raw=true" width="800"></p>

3. Click the 'Dependency Rule' drop down and select the 'Range of Versions' option.

<p align="center"><img src="./Readme/images/ios-sp-003.png?raw=true" width="800"></p>

4. Make sure the version values range from 1.0.0 to 2.0.0 and then click the 'Add Package' button.

<p align="center"><img src="./Readme/images/ios-sp-004.png?raw=true" width="800"></p>

5. In the dialog box that displays, make sure you have selected the correct Target and then click on the 'Add Package' button

<p align="center"><img src="./Readme/images/ios-sp-005.png?raw=true" width="800"></p>

6. The package has now been added. In the Package Dependencise section of your project explorer, make sure the version is correct. At this time the latest version is 1.6.2.

<p align="center"><img src="./Readme/images/ios-sp-006.png?raw=true" width="800"></p>

### Cocoapods

SmartCallingSDK is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

`pod 'SmartCallingSDK'`

Make sure you run `pod install` from command line. Note that this technique requires Cocoapods 1.9 and above. We are aware that there have been some problems with pods on M1 macs which is why we highly recommend using the Swift Package method discussed above.

### Manual Installation

The SmartCalling.xcframework has been included in this repository. You can drag and drop the file directly to your Xcode project. Make sure that it is visible in your project settings as Embed & Sign.

## Project Setup

To add contacts to users device, the app needs permission for accessing Contacts. You need to add a usage description in the `Info.plist` file for the key `NSContactsUsageDescription` with a text value.

<img src="https://github.com/Smartcalling/SmartCalling-iOS/blob/master/Readme/permission.png?raw=true" width="400">

The library will initally ask for user's permission. If the user denies it, the library will not be able to add profiles and return an error. For a better user experience, the app can check if the user has denied Contacts permission and present a pop-up if so. This logic should be introduced by the app developer.

## Usage

1. In order to use the framework it needs to be imported first. It's pretty straightforward in Swift:
```swift
import SmartCalling
```

2. If you haven't already, you will need to add your app to the SmartCom portal (see above). Once this is done, you will be provided with an API Key. Before using any other functions of the library, the API Key needs to be set.<br/>
The SDK will set an email address to the contacts it creates which should be unique to your application. The SDK will run queries for that email and it is important that you set a unique corportateEmail when you initialize SmartCallingManager.<br/>
The library uses the SmartCalling servers by default. If you do not intend to use your own server then you must use our UAT server for testing (https://portal-uat.smartcom.net/). Once you are ready to go live you will need to contact SmartCom to enable your organisation on the live server, you will then be provided with our live server address.<br/>If you are using your own server, just override the value as shown below:
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
  SmartCallingManager.shared.apiKey = "XXXX-XXXX-XXXX-XXXX"
  SmartCallingManager.shared.corporateEmail = "info@company.com"
  SmartCallingManager.shared.url = URL(string: "https://YOUR_SERVER_ADDRESS")!

  return true
}
```

3. Everytime you call library's updateProfiles function, all the contacts will be updated if there is a change in your remote configuration. For example 'applicationDidBecomeActive' might be a good place to update profiles. If you are using a Scene Delegate you will need to add this code to your 'sceneDidBecomeActive' function instead.
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
4. An assumption is made that your app will have a login process that results in the app receiving user information. For the library to work completely, your login process must return a unique ID for the user logged in. This unique ID must be passed to the library using the following code (where XXX is the unique user ID):
```swift
func loginSucessful(_ userInfo: UserInfo) { // Hypothetical function defined in the app which is called after a successful login.  
  SmartCallingManager.shared.setClientId("XXX") { error in
    if let error = error {
      print("SmartCalling setClientId Failed: \(error)")
    } else {
      print("SmartCalling setClientId Succeeded")
    }
  }
}
```
The library will automatically update profiles for the given client ID, so no need to call updateProfiles separately.

5. If your app has a logout process, please add code to call the logOut function in the library:
```swift
func logOut() { // Hypothetical function defined in the app which is called when user logs out of your app.  
  SmartCallingManager.shared.logOut();
}
```

## SSL Pinning

By default the library includes SSL pinning for all SmartCalling certificates however, if you are hosting the SmartCalling API in your own environment you will have to provide information concerning where the library can download your certificate. To do this you will first need to place your certificate .der file in a location accessible to the library via a URL. To download your certificate you can run this function on your command line:
```
openssl s_client -connect <yourURL>:443 -showcerts < /dev/null | openssl x509 -outform DER > <yourFileName>.der
```
Please replace ```<yourURL>``` with the URL to the HTTPS location of your API instance and replace ```<yourFileName>``` with the name you want to give your certificate file. Once downloaded, place your certificate file in a location accessible via a URL.

Once this is done, you will need to provide the library with the certificate information before you make any other calls to the library. To set the certificate location and file name you will need to call the 'setCertificateLocation' function:
```
SmartCallingManager.shared.setCertificateLocation(url: "https://www.myurl.com/", fileName: "myCertificate.der") { (success: Bool) in
  if (success) {
    ...
  }
};

```

Replace the URL and FileName parameters with your certificate URL and file name. Please note the url does not contain the .der file simply the location of the file.
You should only make subsequent calls to the SmartCalling library if this function returns a true result in the completion handler.


## Enable Remote Update

Remote profile update works with silent push notifications. The SmartCalling Demo uses Firebase Cloud Messaging to register for push notification. While the demo solution uses FCM as its push solution you are in no way limited to Google Firebase to manage your push notifications. If you are using, or are planning to use, a different system then please let us know and we will make sure your solution is supported. Please follow the [iOS setup instructions on Firebase website](https://firebase.google.com/docs/cloud-messaging/ios/client). When you receive the FCM Token, subscribe to Smartcalling topics and register the token then direct didReceiveRemoteNotification calls to SmartCallingManager's processRemoteNotification function as shown below:

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

You can refer to the Example application code hosted on SmartCalling iOS Library GitHub page.

## Background App Refresh

Please note that background refresh is only relevant if you are using our portal to create and manage your campaigns. If you are creating campaigns via your Contact Management System then backround updating will serve no purpose.<br/>
This native iOS feature can be used to trigger synchronization of SmartCalling contacts even if the application is in the background. Please first follow [this Apple Documentation](https://developer.apple.com/documentation/uikit/core_app/managing_your_app_s_life_cycle/preparing_your_app_to_run_in_the_background/updating_your_app_with_background_app_refresh) page to setup background refresh for your application. After that all you need to do is to start the SmartCalling update process as shown below:

```swift
func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
  SmartCallingManager.shared.updateProfiles { error in
    let result: UIBackgroundFetchResult = error == nil ? .newData : .failed
    completionHandler(result)
  }
}
```
Please note that background processes can affect both battery and data usage on your user's device.

## Anti-Vishing (with CallKit extension)

The following section is only relevant if you are using the SmartCalling Anti-Vishing feature.<br/>
In order to activate SmartCalling Anti-Vishing feature, you first need to create a Call Directory Extension.

<img src="https://github.com/Smartcalling/SmartCalling-iOS/blob/master/Readme/callkit.png?raw=true" width="400">

If you are using Cocoapods to install the library, please make sure the SmartCallingSDK pod is added for the new extension target. If you're manually installing the framework, make sure that it is visible in your project settings as Do Not Embed (not Embed & Sign).

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

## Debugging

You can enable debug logs with `SmartCallingManager.shared.setDebugLoggingEnabled(true)` and then the SDK will print additional logs to console for diagnostics. 

## Support & FAQ

If you require support for your SmartCom integration please first request a support account by emailing Donovan@smartcom.net. Once the email is received you will be sent an activation email. Please follow the instructions in the email to set up your account and password. Once complete, you will be able to login to our support system to create tickets. Please note that we only provide one support account per organisation.
<br/>
<br/>
<br/>
**Q1. What size and format should my campaign images be?**<br/>
For IOS we recommend a square image (1:1) ideally 200 * 200 pixels in size. For Android we recommend a ratio of 4:3 with a recommended size of 480 * 360 pixels.
		
**Q2. Is Client Ready or Are Clients Ready API calls returning True after Push Campaign cancelled**<br/>
It is possible for a true response if the device in question has been turned off or is not able to receive push notifications.<br/>
Consider this scenario: Phone A and phone B are both switched on. A push campaign is sent to both phones, each phone receives the push and sets the device up ready to receive a call. A call to 'Is Client Ready' for each device returns true. Phone B is then switched off or moves into an area with no signal. The client sends a 'Cancel Push Campaign' to each device. Because only phone A is able to receive the push, only phone A removes the campaign. Phone B has no signal or is switched off so does not receive the push and is therefor still set up to receive the campaign call. When an 'Is Client Ready' call is now made for each phone, phone A returns false but phone B still returns true because it has not received the cancel push.

