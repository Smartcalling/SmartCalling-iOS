//
//  SmartCallingCallDirectoryHandler.h
//  SmartCallingSDK
//
//  Created by Deniz Adalar on 05/01/2018.
//  Copyright © 2018 SmartCalling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CallKit/CallKit.h>

NS_AVAILABLE_IOS(10_0)
@interface SmartCallingCallDirectoryHandler : NSObject

+(instancetype)shared;
- (void)importProfilesFromEmbeddedPlist:(CXCallDirectoryExtensionContext *)context;

@end
