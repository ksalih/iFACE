//
//  ChangeUserInfoViewController.h
//  FieldOps Mobile
//
//  Created by Jorge Carvallo on 3/28/13.
//  Copyright (c) 2013 Deloitte for US Department of Transportation Pipeline and Hazardous Materials Safety Administration. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ChangeUserInfoViewController : UITableViewController
- (IBAction)doneButtonAction:(id)sender;
- (IBAction)cancelButtonAction:(id)sender;

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *fullName;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *verifyPassword;

@property (strong,nonatomic) User *currentUser;
@end
