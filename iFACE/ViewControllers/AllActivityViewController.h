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

@interface AllActivityViewController : UITableViewController <SlideMenuViewControllerClient,UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDelegate,UIActionSheetDelegate,NSFetchedResultsControllerDelegate,UITableViewDataSource>

@property (strong,nonatomic) SlideMenuViewController *slideMenuViewController;
@property (strong, nonatomic) IBOutlet ActivityCell *activityCell;
@property (nonatomic, strong) NSString *searchString;

- (void) registerSlideMenuViewController:(SlideMenuViewController *) slideMenuViewController;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *slideMenuButton;

- (IBAction)slideMenuAction:(id)sender;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) UIRefreshControl* refreshControl;
- (IBAction)imageTapped:(id)sender;

@end
