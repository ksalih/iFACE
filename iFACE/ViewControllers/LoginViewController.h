//
//  LoginViewController.h
//  iFACE
//
//  Created by Jorge Carvallo on 4/5/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GreyImageButton.h"
#import "SFRestAPI.h"

@interface LoginViewController : UIViewController <SFRestDelegate>

@property (weak, nonatomic) IBOutlet UIView *credentialsView;
- (IBAction)signinAction:(id)sender;
@property (weak, nonatomic) IBOutlet GreyImageButton *registerButton;
- (IBAction)registerAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UITextField *userName;
@end
