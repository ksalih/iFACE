//
//  AllActivityViewController.h
//  iFACE
//
//  Created by Jorge Carvallo on 4/7/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobileBrokerClient.h"
#import "SlideMenuViewController.h"

@interface AllActivityViewController : UITableViewController <SlideMenuViewControllerClient>

@property (strong,nonatomic) SlideMenuViewController *slideMenuViewController;

- (void) registerSlideMenuViewController:(SlideMenuViewController *) slideMenuViewController;

- (IBAction)slideMenuAction:(id)sender;
@end
