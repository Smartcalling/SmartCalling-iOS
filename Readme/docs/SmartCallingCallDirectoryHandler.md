# SmartCallingCallDirectoryHandler

``` swift
open class SmartCallingCallDirectoryHandler: CXCallDirectoryProvider 
```

## Inheritance

`CXCallDirectoryExtensionContextDelegate`, `CXCallDirectoryProvider`

## Properties

### `url`

URL of the SmartCalling server. Defaults to 'https:​//portal.smartcom.net'.

``` swift
open var url: URL = URL(string: "https://portal.smartcom.net")!
```

### `apiKey`

API Key for the application created in SmartCom portal. Must be set before
using SDK functionality.

``` swift
open var apiKey: String? = nil
```

## Methods

### `beginRequest(with:)`

``` swift
override open func beginRequest(with context: CXCallDirectoryExtensionContext) 
```

### `requestFailed(for:withError:)`

``` swift
open func requestFailed(
    for extensionContext: CXCallDirectoryExtensionContext,
    withError error: Error)
```
