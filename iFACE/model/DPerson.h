//
//  DPerson.h
//  iFACE
//
//  Created by Karwan Salih on 4/7/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DActivity, PPDAssoc, PPDCIOAssoc;

@interface DPerson : NSManagedObject

@property (nonatomic, retain) NSString * cellPhone;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * facebookURL;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSDate * lastModifiedDate;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * linkedinURL;
@property (nonatomic, retain) NSString * remoteID;
@property (nonatomic, retain) NSString * serviceArea;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * street;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * twitterURL;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSSet *dActivities;
@property (nonatomic, retain) NSSet *ppdAssocs;
@property (nonatomic, retain) NSSet *ppdCIOAssocs;
@end

@interface DPerson (CoreDataGeneratedAccessors)

- (void)addDActivitiesObject:(DActivity *)value;
- (void)removeDActivitiesObject:(DActivity *)value;
- (void)addDActivities:(NSSet *)values;
- (void)removeDActivities:(NSSet *)values;

- (void)addPpdAssocsObject:(PPDAssoc *)value;
- (void)removePpdAssocsObject:(PPDAssoc *)value;
- (void)addPpdAssocs:(NSSet *)values;
- (void)removePpdAssocs:(NSSet *)values;

- (void)addPpdCIOAssocsObject:(PPDCIOAssoc *)value;
- (void)removePpdCIOAssocsObject:(PPDCIOAssoc *)value;
- (void)addPpdCIOAssocs:(NSSet *)values;
- (void)removePpdCIOAssocs:(NSSet *)values;

@end
