//
//  PPDAssoc.h
//  iFACE
//
//  Created by Karwan Salih on 4/7/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DPerson;

@interface PPDAssoc : NSManagedObject

@property (nonatomic, retain) NSString * dPerson;
@property (nonatomic, retain) NSString * dPersonRelated;
@property (nonatomic, retain) NSDate * lastModifiedDate;
@property (nonatomic, retain) NSSet *dpersonInfo;
@end

@interface PPDAssoc (CoreDataGeneratedAccessors)

- (void)addDpersonInfoObject:(DPerson *)value;
- (void)removeDpersonInfoObject:(DPerson *)value;
- (void)addDpersonInfo:(NSSet *)values;
- (void)removeDpersonInfo:(NSSet *)values;

@end
