//
//  IFACECoredataHelper.h
//  iFACE
//
//  Created by Jorge Carvallo on 4/6/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPerson.h"
#import "ZKUserInfo.h"
#import "DPerson.h"
#import "DCIO.h"
#import "DActivity.h"
#import "zkSObject.h"

@interface IFACECoredataHelper : NSObject
+ (DPerson *) getDPersonByEmail:(NSString *) emailAddress withManagedObjectContext:(NSManagedObjectContext *) managedObjectContext;
+ (DPerson *) addOrUpdatePerson:(ZKUserInfo *) userInfo withManagedObjectContext:(NSManagedObjectContext *) managedObjectContext;
+ (void) copyZKSObject:(ZKSObject *)zkSObject toPerson:(DPerson *)person;
+ (void) copyZKSObject:(ZKSObject *)zkSObject toCIO:(DCIO *)cio;
+ (void) copyZKSObject:(ZKSObject *)zkSObject toActivity:(DActivity *)activity;
+ (NSString *) getUTCString:(NSDate *) date;
@end
