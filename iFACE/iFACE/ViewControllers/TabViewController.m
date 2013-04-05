//
//  TabViewController.m
//  iFACE
//
//  Created by Jorge Carvallo on 4/5/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import "TabViewController.h"

@implementation TabViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - SlideMenuClient methods



- (void) registerSlideMenuViewController:(SlideMenuViewController *) slideMenuViewController{
    self.slideMenuViewController = slideMenuViewController;
}
#pragma mark - Button Actions

- (IBAction)slideMenuAction:(id)sender {
    [self.slideMenuViewController slideMenu];
}
@end
