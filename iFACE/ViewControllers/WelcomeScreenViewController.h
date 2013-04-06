//
//  WelcomeScreenViewController.h
//  iFACE
//
//  Created by Jorge Carvallo on 4/5/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobileBrokerClient.h"

@interface WelcomeScreenViewController : UIViewController <MobileBrokerClientDelegate>
- (IBAction)signInButton:(id)sender;

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;

@end
