//
//  SmartCallingManager.h
//  SmartCallingSDK
//
//  Created by Deniz Adalar on 12/12/2017.
//  Copyright © 2017 SmartCalling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmartCallingManager : NSObject

+(instancetype)shared;
-(void)setApiKey:(NSString*)apiKey;
-(void)importProfilesFromEmbeddedPlist:(void (^)(NSError* error))completionHandler;
-(void)updateProfiles:(void (^)(NSError* error))completionHandler;
-(NSString *)FCMTopic;
-(void)registerFCMToken:(NSString*)FCMToken completionHandler:(void (^)(NSError* error))completionHandler;

@end
