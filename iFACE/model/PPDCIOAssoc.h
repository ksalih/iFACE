//
//  PPDCIOAssoc.h
//  iFACE
//
//  Created by Jorge Carvallo on 4/6/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DCIO, DPerson;

@interface PPDCIOAssoc : NSManagedObject

@property (nonatomic, retain) NSString * dCIO;
@property (nonatomic, retain) NSString * dPerson;
@property (nonatomic, retain) NSString * relationshipLength;
@property (nonatomic, retain) NSString * relationshipType;
@property (nonatomic, retain) NSString * strength;
@property (nonatomic, retain) DPerson *dpersonInfo;
@property (nonatomic, retain) DCIO *dcioInfo;

@end
