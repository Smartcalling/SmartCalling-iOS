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
pod 'SmartCallingSDK', :git => 'git@github.com:Smartcalling/SmartCalling-iOS.git'
```

### Manual Installation

Alternatively you can download SmartCalling.framework from this repository and manually add it to your project.

## Usage

### 1. [Contacts](Readme/Contacts.md)

This approach will add profile(s) on users Contacts application. An image and label can be assigned to profiles.

### 2. [Call Identification (CallKit)](Readme/CallKit.md)

This approach uses Phone app's Call Identification feature. Only a label (along with your application name) will be shown for numbers.

