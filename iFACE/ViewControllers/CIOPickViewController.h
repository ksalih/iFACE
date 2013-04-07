//
//  CIOPickViewController.h
//  iFACE
//
//  Created by Jorge Carvallo on 4/6/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSVenue.h"

@interface CIOPickViewController : UIViewController <UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDelegate,UIActionSheetDelegate,NSFetchedResultsControllerDelegate>

@property (weak,nonatomic) IBOutlet UISearchBar *searchBar;
#pragma mark - Core Data

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSString *searchString;

@property (strong, nonatomic) UIRefreshControl* refreshControl;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong,nonatomic) FSVenue *venue;
@end
