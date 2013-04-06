//
//  WelcomeScreenViewController.m
//  iFACE
//
//  Created by Jorge Carvallo on 4/5/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import "WelcomeScreenViewController.h"
#import "AppDelegate.h"

@implementation WelcomeScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
}

- (void) viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signInButton:(id)sender {
    //check if we have a client, if not, redirect to the salesforce site to login
    if (![MobileBrokerClient sharedClient].client){
        AppDelegate *myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [MobileBrokerClient sharedClient].delegate = self;
        [myAppDelegate startLogin];
    }else{
        //redirect to the next page and continue
    }
    
}

- (void) mobileBrokerClient:(MobileBrokerClient *)caller didFinishLoginWithClient:(ZKSforceClient *) client{
    NSLog(@"Finished loggin into the application");
    [[MobileBrokerClient sharedClient] requestCIOData];
   // [self performSegueWithIdentifier:@"mainApplicationSegue" sender:self];
}

@end
