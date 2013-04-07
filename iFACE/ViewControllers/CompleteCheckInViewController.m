//
//  CompleteCheckInViewController.m
//  iFACE
//
//  Created by Jorge Carvallo on 4/7/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import "CompleteCheckInViewController.h"
#import "JYGraphicsHelper.h"
#import "AppDelegate.h"
#import "AppDefinitions.h"
#import "DActivity.h"

@implementation CompleteCheckInViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"TableBG"]];
    self.view.backgroundColor = background;
    
    [JYGraphicsHelper addShadowAndRoundCornersToLayer:self.textView.layer withRadious:8];
    self.checkinMessageLabel.text = [NSString stringWithFormat:@"Checking with %@ %@",self.selectedCIO.firstName,self.selectedCIO.lastName];
    
    self.managedObjectContext = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkInAction:(id)sender {
    DActivity *myActivity;
    
}
@end
