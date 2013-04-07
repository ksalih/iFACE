//
//  ApplicationPreferences.h
//  iControlU
//
//  Created by Jorge Carvallo on 10/29/12.
//  Copyright (c) 2012 jylups. All rights reserved.
//

/**
 Wraper class to save preferences into the [NSUserDefaults standardUserDefaults] dictionary
 */
#import <Foundation/Foundation.h>

@interface ApplicationPreferences : NSObject


+ (NSURL *) mobileBrokerURL;
+ (void) setMobileBrokerURL: (NSURL *) mobileBrokerURL;

+ (NSString *) applicationUser;
+(void) setApplicationUser: (NSString *) applicationUser;

+(NSString *) applicationPassword;
+(void) setApplicationPassword:(NSString *) applicationPassword;

+(BOOL) isApplicationConfigured;
+(NSNumber *) applicationFetchTime;
+(void) setApplicationFetchTime:(NSNumber *) applicationFetchTime;
+(BOOL) applicationWillSendPushNotifications;
+(void) setApplicationWillSendPushNotifications:(BOOL) yesOrNo;
+(BOOL) applicationWillPlaySounds;
+(void) setApplicationWillPlaySounds:(BOOL) yesOrNo;

+ (void) setPushToken:(NSData *) pushToken;
+ (NSData *) pushToken;

+ (NSDate *) lastSyncDate;
+ (void) setLastSyncDate:(NSDate *)lastSyncDate;
@end
