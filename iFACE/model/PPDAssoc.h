//
//  PPDAssoc.h
//  iFACE
//
//  Created by Jorge Carvallo on 4/6/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DPerson;

@interface PPDAssoc : NSManagedObject

@property (nonatomic, retain) NSString * dPerson;
@property (nonatomic, retain) NSString * dPersonRelated;
@property (nonatomic, retain) DPerson *personAssocToPerson;

@end
