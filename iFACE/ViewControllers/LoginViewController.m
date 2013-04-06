//
//  LoginViewController.m
//  iFACE
//
//  Created by Jorge Carvallo on 4/5/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self addShadowAndRoundCornersToLayer:self.credentialsView.layer];
    self.navigationController.navigationBarHidden = NO;
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
    [layer setShadowRadius:10.0];
    [layer setShadowOffset:CGSizeMake(10.0, 10.0)];
    layer.cornerRadius = 10.0;
    
}

- (IBAction)signinAction:(id)sender {
    NSLog(@"Sign in requested"); //"deloitte123@"
}
@end
