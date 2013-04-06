//
//  MeViewController.m
//  iFACE
//
//  Created by Jorge Carvallo on 4/6/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import "MeViewController.h"
#import "JYGraphicsHelper.h" 

@implementation MeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"TableBG"]];
    self.view.backgroundColor = background;
    [JYGraphicsHelper addShadowAndRoundCornersToLayer:self.userContainerView.layer withRadious:5];
    
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
- (IBAction)imageTapped:(id)sender {
    [self performSegueWithIdentifier:@"checkInSegue" sender:self];
}

- (IBAction)slideMenuAction:(id)sender{
    [self.slideMenuViewController slideMenu];
}
@end
