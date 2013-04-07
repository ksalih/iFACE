//
//  DCIO.h
//  iFACE
//
//  Created by Karwan Salih on 4/7/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DActivity, PPDCIOAssoc;

@interface DCIO : NSManagedObject

@property (nonatomic, retain) NSString * agency;
@property (nonatomic, retain) NSString * budgetAuthority;
@property (nonatomic, retain) NSNumber * currentlyBeenMarked;
@property (nonatomic, retain) NSNumber * currentlyUnderContract;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * facebookURL;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSDate * lastModifiedDate;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * linkedinURL;
@property (nonatomic, retain) NSNumber * moneyToSpend;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * remoteID;
@property (nonatomic, retain) NSDecimalNumber * sizeOfBudget;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * topicsToAvoid;
@property (nonatomic, retain) NSString * twitterURL;
@property (nonatomic, retain) NSSet *dActivities;
@property (nonatomic, retain) NSSet *ppdCIOAssocs;
@end

@interface DCIO (CoreDataGeneratedAccessors)

- (void)addDActivitiesObject:(DActivity *)value;
- (void)removeDActivitiesObject:(DActivity *)value;
- (void)addDActivities:(NSSet *)values;
- (void)removeDActivities:(NSSet *)values;

- (void)addPpdCIOAssocsObject:(PPDCIOAssoc *)value;
- (void)removePpdCIOAssocsObject:(PPDCIOAssoc *)value;
- (void)addPpdCIOAssocs:(NSSet *)values;
- (void)removePpdCIOAssocs:(NSSet *)values;

@end
