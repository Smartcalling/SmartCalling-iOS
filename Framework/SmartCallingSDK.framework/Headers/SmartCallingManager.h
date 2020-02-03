//
//  SmartCallingManager.h
//  SmartCallingSDK
//
//  Created by Deniz Adalar on 12/12/2017.
//  Copyright (c) 2020 Incall Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmartCallingManager : NSObject

@property (nonatomic, copy) NSString *applicationName;

/**
 Flag to enable debug logs.
 */
 @property (atomic) BOOL enableDebugMode;

/**
 Decalare SmartCallingManager
 
 @return Shared `SmartCallingManger` instance.
 */
+ (instancetype)shared;

- (void)setApiKey:(NSString*)apiKey;

- (void)setServerUrl:(NSString*)serverUrl;

/**
 Get Contact from EmbeddedPlist and add to contact list
 
 when app is loading, it import profiles form embedded plist.
 When called on ApplicationDidFinishLaunching, the app hangs and crashes.
 
 */
- (void)importProfilesFromEmbeddedPlist:(void (^)(NSError* error))completionHandler;

/**
 Profile update
 
 when App is loading it calls and update profile
 When called on ApplicationDidFinishLaunching, the app hangs and crashes
 */
- (void)updateProfiles:(void (^)(NSError* error))completionHandler;

/**
 Register FCMToken
 
 it call http response with bundleName, smartCallingId and FCMToken
 */
- (void)registerFCMToken:(NSString*)FCMToken completionHandler:(void (^)(NSError* error))completionHandler;

/**
 Get SmartCalling Id from Device info
 
 Get current Device uuid and it convert to string.
 
 @return
 it returns a string of type NSMutableString.
 */
- (NSString*)getSmartCallingId;

/**
 it returns string like "smartcalling-XXX" from api key.
 */
- (NSString *)FCMTopic;

@end
