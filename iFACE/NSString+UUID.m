//
//  NSString+UUID.m
//  FieldOps Mobile
//
//  Created by Jorge Carvallo on 9/11/12.
//  Copyright (c) 2012 Deloitte for US Department of Transportation Pipeline and Hazardous Materials Safety Administration. All rights reserved.

#import "NSString+UUID.h"

@implementation NSString (UUID)

+ (NSString*)UUIDString {
    
    CFUUIDRef theUUID = CFUUIDCreate(kCFAllocatorDefault);
    NSString *string = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, theUUID);
    CFRelease(theUUID);
    
    return string;
    
}

@end
