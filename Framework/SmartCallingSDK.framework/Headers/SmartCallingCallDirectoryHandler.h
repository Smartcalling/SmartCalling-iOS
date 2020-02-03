//
//  SmartCallingCallDirectoryHandler.h
//  SmartCallingSDK
//
//  Created by Deniz Adalar on 05/01/2018.
//  Copyright (c) 2020 Incall Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CallKit/CallKit.h>

NS_AVAILABLE_IOS(10_0)
@interface SmartCallingCallDirectoryHandler : NSObject

/**
 Decalare SmartCallingManager
 
 @return Shared `SmartCallingCallDirectoryHandler` instance.
 */
+ (instancetype)shared;

/**
 Get SmartCalling ID from Device info
 
 Get current Device uuid and it convert to string.
 */
- (void)importProfilesFromEmbeddedPlist:(CXCallDirectoryExtensionContext *)context;

@end
