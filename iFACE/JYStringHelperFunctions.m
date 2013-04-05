//
//  JYStringHelperFunctions.m
//
//  This file is part of the Jylups LLC application common framework
//
//  Created by Jorge Carvallo on 11/9/12.
//  Copyright (c) 2012 Jylups LLC. All rights reserved.
//

#import "JYStringHelperFunctions.h"
#import "NSData+Base64.h"

@implementation JYStringHelperFunctions

+(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; 
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+(NSString*) sha1:(NSString*)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}

+ (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}

+ (NSString *) getBasicAuthenticationTokenForUser:(NSString *) user withPassword:(NSString *)password{
    NSString *basicAuthToken=nil;
    NSURL *url = [[NSURL alloc] initWithString:@"http://localhost"];
    
    CFHTTPMessageRef dummyRequest = CFHTTPMessageCreateRequest(kCFAllocatorDefault, (CFStringRef)@"GET", (__bridge CFURLRef) url, kCFHTTPVersion1_1);
    if (dummyRequest) {
        CFHTTPMessageAddAuthentication(dummyRequest, nil, (__bridge CFStringRef)user, (__bridge CFStringRef)password, kCFHTTPAuthenticationSchemeBasic, FALSE);
        CFStringRef authorizationString = CFHTTPMessageCopyHeaderFieldValue(dummyRequest, CFSTR("Authorization"));
        if (authorizationString) {
            basicAuthToken = (__bridge NSString *)authorizationString;
            CFRelease(authorizationString);
        }
        CFRelease(dummyRequest);
    }
    return basicAuthToken;
}

+ (NSString *)base64Encode:(NSString *)plainText
{
    NSData *plainTextData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainTextData base64EncodedString];
    return base64String;
}

+ (NSString *)base64Decode:(NSString *)base64String
{
    NSData *plainTextData = [NSData dataFromBase64String:base64String];
    NSString *plainText = [[NSString alloc] initWithData:plainTextData encoding:NSUTF8StringEncoding];
    return plainText;
}

@end
