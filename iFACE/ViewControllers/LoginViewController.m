//
//  LoginViewController.m
//  iFACE
//
//  Created by Jorge Carvallo on 4/5/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "JYLoadingView.h"
#import "JYGraphicsHelper.h"
#import "zkSforceClient.h"
#import "MobileBrokerClient.h" 
#import "AppDelegate.h"

static NSString *OAUTH_CLIENTID = @"3MVG9A2kN3Bn17huH9WYzmSN6futXVxQtE8pCXq5z_15X5326xwIKPq8r47490Y3tBD3bnkbx6rmPiyDbklRr";


@interface LoginViewController ()

@property (strong,nonatomic) JYLoadingView *loadingView;

@end

@implementation LoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self addShadowAndRoundCornersToLayer:self.credentialsView.layer];
    self.navigationController.navigationBarHidden = NO;
    self.registerButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.registerButton.layer.shadowOpacity = 0.8;
    self.registerButton.layer.shadowRadius = 8;
    self.registerButton.layer.shadowOffset = CGSizeMake(8, 8);
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"TableBG.png"]];
    self.view.backgroundColor = background;
    
    [JYGraphicsHelper addRoundCornersToLayer:self.userName.layer withRadious:5];
    [JYGraphicsHelper addRoundCornersToLayer:self.password.layer withRadious:5];


    
}


- (void) viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addShadowAndRoundCornersToLayer:(CALayer *)layer{
    [layer setShadowColor:[UIColor blackColor].CGColor];
    [layer setShadowOpacity:0.8];
    [layer setShadowRadius:8];
    [layer setShadowOffset:CGSizeMake(8, 8)];
    layer.cornerRadius = 10.0;
    
}

- (IBAction)signinAction:(id)sender {
//    NSLog(@"Sign in requested"); 
//    CGRect bounds = self.view.bounds;
//    self.loadingView = [JYLoadingView createLoadingView:bounds withMessage:@"Validating Settings..."];
//    [self.view addSubview:self.loadingView];
//    [self.view setUserInteractionEnabled:NO];
//    [self.navigationController.view setUserInteractionEnabled:NO];
    
//    ZKSforceClient *sforce = [[ZKSforceClient alloc] init];
//   // sforce.clientId = OAUTH_CLIENTID;
//    ZKLoginResult *result = [sforce login:self.userName.text password:self.password.text];
    
    
}
- (IBAction)registerAction:(id)sender {
  //  [[MobileBrokerClient sharedClient] requestCIOData];
    
}



@end
