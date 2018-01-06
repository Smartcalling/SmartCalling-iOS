# Usage - Call Identification

## 1. Create Call Directory Extension

First you need to create a new target for your project. 

<img src="https://raw.githubusercontent.com/Smartcalling/SmartCalling-iOS/master/Readme/call_kit_extension.png" width="400">

## 2. CocoaPods

Make sure that this new target is configured for SmartCallingSDK pod. You can check Example projects Podfile if you're unsure how to do that.

## 3. Resources

Add the profiles plist file named _SmartCallingCallKit.plist_ to the extension target folder. Make sure you select "Copy items if needed" and the extension target below.

<img src="https://raw.githubusercontent.com/Smartcalling/SmartCalling-iOS/master/Readme/call_kit_res_1.png" width="200">
<img src="https://raw.githubusercontent.com/Smartcalling/SmartCalling-iOS/master/Readme/call_kit_res_2.png" width="400">

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

## 4. Import Embedded Profiles

To actually use the SDK and import profiles for call identification, use the code below for CallDirectoryHandler. You can delete boilerplate for provided by Xcode.

Swift:
```swift
override func beginRequest(with context: CXCallDirectoryExtensionContext) {
    context.delegate = self

    SmartCallingCallDirectoryHandler.shared().importProfiles(fromEmbeddedPlist: context)

    context.completeRequest()
}
```
Objective-C:
```objective-c
-(void)beginRequestWithExtensionContext:(CXCallDirectoryExtensionContext *)context {
    context.delegate = self;

    [SmartCallingCallDirectoryHandler.shared importProfilesFromEmbeddedPlist:context];

    [context completeRequestWithCompletionHandler:nil];
}
```
## 5. How-to enable Call Identification

Users will need to manually enable Call Identification to benefit from this feature. You can choose to notify users how to do this with an Alert View or a custom screen. They need to open *Settings > Phone > Call Blocking & Identification* and enable your application.

<img src="https://raw.githubusercontent.com/Smartcalling/SmartCalling-iOS/master/Readme/call_kit_settings.png" width="600">