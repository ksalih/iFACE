//
//  MeViewController.h
//  iFACE
//
//  Created by Jorge Carvallo on 4/6/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideMenuViewController.h"

@interface MeViewController : UIViewController <SlideMenuViewControllerClient>

@property (strong,nonatomic) SlideMenuViewController *slideMenuViewController;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *slideMenuButton;
@property (weak, nonatomic) IBOutlet UIView *userContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *userPictureImageView;
- (IBAction)imageTapped:(id)sender;

- (IBAction)slideMenuAction:(id)sender;

- (void) registerSlideMenuViewController:(SlideMenuViewController *) slideMenuViewController;

@end
