//
//  CIOSearchViewController.h
//  iFACE
//
//  Created by Jorge Carvallo on 4/7/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import "CIOPickViewController.h"
#import "SlideMenuViewController.h"
#import "CIOProfileViewController.h"

@interface CIOSearchViewController : CIOPickViewController <SlideMenuViewControllerClient>

@property (strong,nonatomic) SlideMenuViewController *slideMenuViewController;

- (void) registerSlideMenuViewController:(SlideMenuViewController *) slideMenuViewController;
@property (strong, nonatomic) UIRefreshControl* refreshControl;
- (IBAction)imageTapped:(id)sender;

- (IBAction)slideMenuAction:(id)sender;

@end
