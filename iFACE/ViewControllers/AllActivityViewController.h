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
#import "ActivityCell.h"

@interface AllActivityViewController : UITableViewController <SlideMenuViewControllerClient>

@property (strong,nonatomic) SlideMenuViewController *slideMenuViewController;
@property (strong, nonatomic) IBOutlet ActivityCell *activityCell;

- (void) registerSlideMenuViewController:(SlideMenuViewController *) slideMenuViewController;

- (IBAction)slideMenuAction:(id)sender;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) UIRefreshControl* refreshControl;

@end
