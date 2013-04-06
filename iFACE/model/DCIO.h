//
//  DCIO.h
//  iFACE
//
//  Created by Jorge Carvallo on 4/6/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DCIO : NSManagedObject

@property (nonatomic, retain) NSString * agency;
@property (nonatomic, retain) NSString * budgetAuthority;
@property (nonatomic, retain) NSNumber * currentlyBeenMarked;
@property (nonatomic, retain) NSNumber * currentlyUnderContract;
@property (nonatomic, retain) NSString * dcioName;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * facebookURL;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * linkedinURL;
@property (nonatomic, retain) NSNumber * moneyToSpend;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSDecimalNumber * sizeOfBudget;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * topicsToAvoid;
@property (nonatomic, retain) NSString * twitterURL;
@property (nonatomic, retain) NSManagedObject *cioToPerson;

@end
