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
-(void)importProfilesFromEmbeddedPlist:(void (^)(NSError* error))completionHandler;

@end
