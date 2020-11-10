# SmartCallingManager

``` swift
public final class SmartCallingManager 
```

## Properties

### `shared`

The singleton instance of the SmartCallingManager.

``` swift
public static var shared 
```

### `url`

URL of the SmartCalling server. Defaults to 'https:​//portal.smartcom.net'.

``` swift
public var url: URL = URL(string: "https://portal.smartcom.net")!
```

### `apiKey`

API Key for the application created in SmartCom portal. Must be set before
using SDK functionality.

``` swift
public var apiKey: String? = nil
```

### `contactGroupName`

The group name which will be created in Contacts. Defaults to
application's bundle name defined in Info.plist

``` swift
public var contactGroupName: String 
```

### `version`

Returns current SDK version

``` swift
public let version: String = (
    Bundle(identifier: "net.smartcom.SmartCalling")?
      .infoDictionary?["CFBundleShortVersionString"] as? String
    ) ?? ""
```

## Methods

### `updateProfiles(completionHandler:)`

Checks if there is a change in the remote configuration and applies
updates to contacts accordingly. apiKey must be set before calling this
function.

``` swift
public func updateProfiles(completionHandler: @escaping (Error?) -> ()) 
```

#### Parameters

  - completionHandler: This function will be called upon completion. An optional Error parameter will also be passed to this handler.

### `setClientId(_:completionHandler:)`

Sets the unique user identifier. Ideally this function should be called
after a successful login where a unique id is returned.

``` swift
public func setClientId(
    _ clientId: String?,
    completionHandler: @escaping (Error?) -> ()
  ) 
```

#### Parameters

  - clientId: Unique user identifier. ID will be removed when passed nil.
  - completionHandler: This function will be called upon completion. An optional Error parameter will also be passed to this handler.

### `setFCMToken(_:completionHandler:)`

Sets the Firebase Cloud Messaging (FCM) push token. Ideally this function
should be called the user has authorized to send push notifications and
the application is registered with FCM.

``` swift
public func setFCMToken(
    _ token: String?,
    completionHandler: @escaping (Error?) -> ()
  ) 
```

#### Parameters

  - token: FCM push token. Token will be removed when passed nil. Note; this is not a regular iOS push notification token.
  - completionHandler: This function will be called upon completion. An optional Error parameter will also be passed to this handler.

### `processRemoteNotification(userInfo:completionHandler:)`

Kicks off updateProfiles function if the notification is a SmartCalling
notification. This function should be called when the application
receives a push notification (i.e. applicationDidReceiveRemoteNotification
delegate method).

``` swift
public func processRemoteNotification(
    userInfo: [AnyHashable : Any],
    completionHandler: @escaping (Error?) -> ()
  ) -> Bool 
```

#### Parameters

  - userInfo: userInfo payload passed to applicationDidReceiveRemoteNotification method should be directed.
  - completionHandler: This function will be called upon completion. An optional Error parameter will also be passed to this handler.

#### Returns

Returns true if the notification is a SmartCalling notification otherwise false.
