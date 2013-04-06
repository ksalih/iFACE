//
//  DPerson.h
//  iFACE
//
//  Created by Karwan Salih on 4/6/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DCIO, DPerson;

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
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * street;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * twitterURL;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) DCIO *personToCIO;
@property (nonatomic, retain) DPerson *personToPerson;

@end
