//
//  MainTabViewController.h
//  iFACE
//
//  Created by Jorge Carvallo on 4/5/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideMenuViewController.h"

@interface MainTabViewController : UIViewController <SlideMenuViewControllerClient>
@property (strong,nonatomic) SlideMenuViewController *slideMenuViewController;

- (void) registerSlideMenuViewController:(SlideMenuViewController *) slideMenuViewController;
@end
