//
//  User.h
//  iFACE
//
//  Created by Karwan Salih on 4/7/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * fullName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * username;

@end
