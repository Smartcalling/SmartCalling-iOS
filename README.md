# SmartCallingSDK

[![Version](https://img.shields.io/cocoapods/v/SmartCallingSDK.svg?style=flat)](http://cocoapods.org/pods/SmartCallingSDK)
[![Platform](https://img.shields.io/cocoapods/p/SmartCallingSDK.svg?style=flat)](http://cocoapods.org/pods/SmartCallingSDK)

Using the SmartCalling SDK let's you add a contacts to the iOS AddressBook so users of your app can know when you recive a call from

## Requirements

- iOS 9.0+
- Xcode 8.0+

## Installation

### CocoaPods

SmartCallingSDK is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'SmartCallingSDK'
```

### Manual Installation

Alternatively you can download SmartCalling.framework from this repository and manually add it to your project.

## Usage

### 1. Add Embedded Profiles

First you need to add the profiles folder named _SmartCalling_. It should contain one or more .plist file and some images. Just drag and drop the folder into your project structure. Make sure you select "Copy items if needed", "Create folder references" and the target below.

<img src="https://raw.githubusercontent.com/Smartcalling/SmartCalling-iOS/master/Screenshots/add_folder.png" width="400">

### 2. Permissions

To add contacts to users device, the app needs permission for Contacts. You need to add a usage description in the Info.plist file for the key _NSContactsUsageDescription_ with a text value.

<img src="https://raw.githubusercontent.com/Smartcalling/SmartCalling-iOS/master/Screenshots/permission.png" width="400">

The SDK will initally ask for users permission. If the user denies it, SDK will not be able to add profiles.
For a better user experience, the app can check if the user has denied Contacts permission and present a pop-up if so. This logic should be introduced by the app developer.

### 3. Import Framework

To use the SDK you first need to import it. To do that in Swift just add
```swift
import SmartCallingSDK
```
on top of your Swift file.

If you want to use in an Objective-C class, use this import line:
```objective-c
@import SmartCallingSDK;
```

### 4. Import Embedded Profiles

To actually use the SDK and import profiles on user devices, use the code below for AppDelegate.

Swift:
```swift
func applicationDidBecomeActive(_ application: UIApplication) {
    SmartCallingManager.shared().importProfilesFromEmbeddedPlist()
}
```
Objective-C:
```objective-c
- (void)applicationDidBecomeActive:(UIApplication *)application {
    SmartCallingManager.shared.importProfilesFromEmbeddedPlist;
}
```

In this example importProfilesFromEmbeddedPlist function is called within Application Did Become Active event. It can be used in other places but this will make sure to try again in some error cases like when no permission is given. Calling importProfilesFromEmbeddedPlist multiple times has no performance effects, becuase it'll only update the profiles when necessary. This process is asynchronous and won't block the app.
The return value for importProfilesFromEmbeddedPlist is a Boolean for checking if the import has succeeded or not. 

