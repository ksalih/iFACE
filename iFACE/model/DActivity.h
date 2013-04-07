//
//  DActivity.h
//  iFACE
//
//  Created by Jorge Carvallo on 4/6/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DCIO, DPerson;

@interface DActivity : NSManagedObject

@property (nonatomic, retain) NSString * activityType;
@property (nonatomic, retain) NSString * badgeAwarded;
@property (nonatomic, retain) NSString * badgeType;
@property (nonatomic, retain) NSString * dCIO;
@property (nonatomic, retain) NSString * dPerson;
@property (nonatomic, retain) NSNumber * geoLat;
@property (nonatomic, retain) NSNumber * geoLong;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * remoteID;
@property (nonatomic, retain) NSString * venue;
@property (nonatomic, retain) DCIO *dcioInfo;
@property (nonatomic, retain) DPerson *dpersonInfo;

@end
