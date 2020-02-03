//
//  CallDirectoryHandler.swift
//  SmartCallingCallKitProvider
//
//  Created by Deniz Adalar on 05/01/2018.
//  Copyright (c) 2020 Incall Ltd. All rights reserved.
//

import Foundation
import CallKit
import SmartCallingSDK

class CallDirectoryHandler: CXCallDirectoryProvider
{
    override func beginRequest(with context: CXCallDirectoryExtensionContext)
    {
        context.delegate = self
        
        SmartCallingCallDirectoryHandler.shared().importProfiles(fromEmbeddedPlist: context)
        
        context.completeRequest()
    }
}

extension CallDirectoryHandler: CXCallDirectoryExtensionContextDelegate
{
    func requestFailed(for extensionContext: CXCallDirectoryExtensionContext, withError error: Error)
    {
        // An error occurred while adding blocking or identification entries, check the NSError for details.
        // For Call Directory error codes, see the CXErrorCodeCallDirectoryManagerError enum in <CallKit/CXError.h>.
        //
        // This may be used to store the error details in a location accessible by the extension's containing app, so that the
        // app may be notified about errors which occured while loading data even if the request to load data was initiated by
        // the user in Settings instead of via the app itself.
    }
}
