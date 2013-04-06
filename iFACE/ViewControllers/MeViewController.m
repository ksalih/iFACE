//
//  MeViewController.m
//  iFACE
//
//  Created by Jorge Carvallo on 4/6/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import "MeViewController.h"

@implementation MeViewController

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

- (void) registerSlideMenuViewController:(SlideMenuViewController *) slideMenuViewController{
    self.slideMenuViewController = slideMenuViewController;
}

#pragma mark - actions
- (IBAction)slideMenuAction:(id)sender{
    [self.slideMenuViewController slideMenu];
}
@end
