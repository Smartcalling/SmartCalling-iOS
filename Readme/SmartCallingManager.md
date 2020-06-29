# SmartCallingManager

``` swift
public final class SmartCallingManager
```

## Properties

### `shared`

The singleton instance of the SmartCallingManager.

``` swift
var shared
```

### `url`

URL of the SmartCalling server. Defaults to 'https://portal.smartcom.net'.

``` swift
var url: URL
```

### `apiKey`

API Key for the application created in SmartCom portal. Must be set before
using SDK functionality.

``` swift
var apiKey: String?
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

  - completionHandler: - completionHandler: This function will be called upon completion. An optional Error parameter will also be passed to this handler.

### `setClientId(_:completionHandler:)`

Sets the unique user identifier. Ideally this function should be called
after a successful login where a unique id is returned.

``` swift
public func setClientId(_ clientId: String?, completionHandler: @escaping (Error?) -> ())
```

#### Parameters

  - clientId: - clientId: Unique user identifier. ID will be removed when passed nil.
  - completionHandler: - completionHandler: This function will be called upon completion. An optional Error parameter will also be passed to this handler.

### `setFCMToken(_:completionHandler:)`

Sets the Firebase Cloud Messaging (FCM) push token. Ideally this function
should be called the user has authorized to send push notifications and
the application is registered with FCM.

``` swift
public func setFCMToken(_ token: String?, completionHandler: @escaping (Error?) -> ())
```
