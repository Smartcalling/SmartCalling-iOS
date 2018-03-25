# Usage - Contacts

## 1. Add Embedded Profiles

First you need to add the profiles folder named _SmartCalling_. It should contain one or more .plist file and some images. Just drag and drop the folder into your project structure. Make sure you select "Copy items if needed", "Create folder references" and the target below.

<img src="https://raw.githubusercontent.com/Smartcalling/SmartCalling-iOS/master/Readme/add_folder.png" width="400">

Sample SmartCalling folder can be found in the example project. (SmartCalling-iOS/Example/SmartCalling/SmartCalling)

## 2. Permissions

To add contacts to users device, the app needs permission for Contacts. You need to add a usage description in the Info.plist file for the key _NSContactsUsageDescription_ with a text value.

<img src="https://raw.githubusercontent.com/Smartcalling/SmartCalling-iOS/master/Readme/permission.png" width="400">

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

Swift:
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
Objective-C:
```objective-c
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [SmartCallingManager.shared importProfilesFromEmbeddedPlist:^(NSError *error) {
        if (error) {
            NSLog(@"SmartCalling Import Profiles Failed: %@", error.localizedDescription);
        } else {
            NSLog(@"SmartCalling Import Profiles Succeeded");
        }
    }];
}
```

In this example importProfilesFromEmbeddedPlist function is called within Application Did Become Active event. It can be used in other places but this will make sure to try again in some error cases like when no permission is given. Calling importProfilesFromEmbeddedPlist multiple times has no performance effects, becuase it'll only update the profiles when necessary. This process is asynchronous and won't block the app.

## 5. Update Profiles (Online Integration)

Online integration works just like offline one but you need to set your Api Key first. Everytime you call SDK's updateProfiles function, all the contacts will be updated if there is a change in your remote configuration. If you want to use both offline and online solutions, make sure that you call updateProfiles function on completion of importProfiles function. Otherwise since these 2 functions are asynchronous, they can clash.

Swift:
```swift
func applicationDidBecomeActive(_ application: UIApplication) {
    SmartCallingManager.shared().setApiKey("XXXX-XXXX-XXXX-XXXX")
    SmartCallingManager.shared().updateProfiles { error in
        if let error = error {
            print("SmartCalling Import Profiles Failed: \(error)")
        } else {
            print("SmartCalling Import Profiles Succeeded")
        }
    }
}
```
Objective-C:
```objective-c
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [SmartCallingManager.shared setApiKey:@"XXXX-XXXX-XXXX-XXXX"];
    [SmartCallingManager.shared importProfilesFromEmbeddedPlist:^(NSError *error) {
        if (error) {
            NSLog(@"SmartCalling Import Profiles Failed: %@", error.localizedDescription);
        } else {
            NSLog(@"SmartCalling Import Profiles Succeeded");
        }
    }];
}
```
