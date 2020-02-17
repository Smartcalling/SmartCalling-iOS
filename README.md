# SmartCalling Sample App

The SmartCalling SDK let's you add your company contact details to the iOS AddressBook.  In this way users of your app will see when they receive a call from your company.

### Build Example

Here are steps to build the example:

- Create an App ID on your iOS developer account
- Configure push notifications for this App ID
- Set the Bundle ID from the App ID at *Xcode > SmartCalling-Example > TARGETS > SmartCalling_Example >  General > Identity > Bundle Identifier*
- Prefix the Bundle ID at *Xcode > SmartCalling-Example > TARGETS > SmartCalling_Example >  General > Identity > Bundle Identifier* with your Bundle ID from above. So this becomes *your.bundle.id.SmartCallingCallKitProvider*.
- Select your *Development Team* in *Build Settings* of the *SmartCalling_Example* target (see above)

### Manual Installation

The SmartCalling.framework has been included with this repository, but you want to make changes to the SDK project you will need to update this file in `Framework/`

- from terminal `pod install`
- open generated workspace file
- Build & Run

## Usage

### 1. [Contacts](Readme/Contacts.md)

This approach will add profile(s) on users Contacts application. An image and label can be assigned to profiles.

### 2. [Call Identification (CallKit)](Readme/CallKit.md)

This approach uses Phone app's Call Identification feature. Only a label (along with your application name) will be shown for numbers.
