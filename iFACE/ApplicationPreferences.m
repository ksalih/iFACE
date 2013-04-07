//
//  ApplicationPreferences.m
//  iControlU
//
// And object that reads the IOS applicaiton preferences designed just for this app
//  Created by Jorge Carvallo on 10/29/12.
//  Copyright (c) 2012 jylups. All rights reserved.
//

/**
 Wraper class to save preferences into the [NSUserDefaults standardUserDefaults] dictionary
 */
#import "ApplicationPreferences.h"

@implementation ApplicationPreferences

static NSString * const MOBILE_BROKER_URL_KEY = @"MOBILE_BROKER_URL";
static NSString * const APPLICATION_USER_KEY= @"APPLICATION_USER";
static NSString * const APPLICATION_PASSWORD_KEY= @"APPLICATION_PASWORD";
static NSString * const APPLICATION_FETCHTIME_KEY= @"APPLICATION_FETCHTIME";
static NSString * const APPLICATION_SEND_PUSH_KEY= @"APPLICATION_SEND_PUSH";
static NSString * const APPLICATION_PLAY_SOUNDS_KEY= @"APPLICATION_PLAY_SOUNDS_KEY";
static NSString * const APPLICATION_LAST_USER= @"APPLICATION_LAST_USER";
static NSString * const APPLICATION_PUSH_TOKEN= @"APPLICATION_PUSH_TOKEN";
static NSString * const MOBILE_BROKER_LAST_SYNC= @"MOBILE_BROKER_LAST_SYNC";



/**
 Check for all settings to be set, doesn't mean they are correct
*/
+(BOOL) isApplicationConfigured{
    if ([ApplicationPreferences mobileBrokerURL]){
        return YES;
    }
    return NO;
}

+ (NSDate *) lastSyncDate {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs synchronize];
    return [prefs objectForKey:MOBILE_BROKER_URL_KEY];
}

+ (void) setLastSyncDate:(NSDate *)lastSyncDate {
     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:lastSyncDate forKey:MOBILE_BROKER_URL_KEY];
    [prefs synchronize];
}

+ (NSURL *) mobileBrokerURL{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs synchronize];
    return [prefs URLForKey:MOBILE_BROKER_URL_KEY];
}

+ (void) setMobileBrokerURL: (NSURL *) mobileBrokerURL{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setURL:mobileBrokerURL forKey:MOBILE_BROKER_URL_KEY];
    [prefs synchronize];

}

+ (NSString *) applicationUser{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs synchronize];
    return [prefs objectForKey:APPLICATION_USER_KEY];
}

+(void) setApplicationUser: (NSString *) applicationUser{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:applicationUser forKey:APPLICATION_USER_KEY];
    [prefs synchronize];
}

+(NSString *) applicationPassword{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs synchronize];
    return [prefs objectForKey:APPLICATION_PASSWORD_KEY];
}

+(void) setApplicationPassword:(NSString *) applicationPassword{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:applicationPassword forKey:APPLICATION_PASSWORD_KEY];
    [prefs synchronize];

}

+(NSNumber *) applicationFetchTime{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs synchronize];
    return [prefs objectForKey:APPLICATION_FETCHTIME_KEY];
}

+(void) setApplicationFetchTime:(NSNumber *) applicationFetchTime{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:applicationFetchTime forKey:APPLICATION_FETCHTIME_KEY];
    [prefs synchronize];
    
}

+(BOOL) applicationWillSendPushNotifications{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs synchronize];
    
    NSNumber *boolNumber = [prefs objectForKey:APPLICATION_SEND_PUSH_KEY];
    return [boolNumber boolValue];
}

+(void) setApplicationWillSendPushNotifications:(BOOL) yesOrNo{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSNumber *boolNumber = [NSNumber numberWithBool:yesOrNo];
    [prefs setObject:boolNumber forKey:APPLICATION_SEND_PUSH_KEY];
    [prefs synchronize];
    
}

+(BOOL) applicationWillPlaySounds{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs synchronize];
    
    NSNumber *boolNumber = [prefs objectForKey:APPLICATION_PLAY_SOUNDS_KEY];
    return [boolNumber boolValue];
}

+(void) setApplicationWillPlaySounds:(BOOL) yesOrNo{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSNumber *boolNumber = [NSNumber numberWithBool:yesOrNo];
    [prefs setObject:boolNumber forKey:APPLICATION_PLAY_SOUNDS_KEY];
    [prefs synchronize];
    
}

+ (void) setPushToken:(NSData *) pushToken{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:pushToken forKey:APPLICATION_PUSH_TOKEN];
    [prefs synchronize];
}
+ (NSData *) pushToken{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs synchronize];
    return [prefs objectForKey:APPLICATION_PUSH_TOKEN];
}

@end
