//
//  JYStringHelperFunctions.h
//
//  This file is part of the Jylups LLC application common framework
//
//  Created by Jorge Carvallo on 11/9/12.
//  Copyright (c) 2012 Jylups LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface JYStringHelperFunctions : NSObject
/*
 * Uses are regular expression to check for a valid email address
 */
+(BOOL) NSStringIsValidEmail:(NSString *)checkString;
/*
 * encrypts using Sha1
 */
+ (NSString*) sha1:(NSString*)input;
/*
 * Encrypts using MD5
 */
+ (NSString *) md5:(NSString *) input;
/**
 * Creates a basic authentication token
 */
+ (NSString *) getBasicAuthenticationTokenForUser:(NSString *) user withPassword:(NSString *)password;

+ (NSString *)base64Encode:(NSString *)plainText;

+ (NSString *)base64Decode:(NSString *)base64String;

@end
