//
//  AllActivityViewController.m
//  iFACE
//
//  Created by Jorge Carvallo on 4/7/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import "AllActivityViewController.h"
#import "AppDefinitions.h"
#import "AppDelegate.h"
#import "ApplicationPreferences.h"
#import "DActivity.h"
#import "DCIO.h"
#import "DPerson.h"

@interface AllActivityViewController () {
    NSDateFormatter *formatter;
}

@end

@implementation AllActivityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"TableBG"]];
    self.tableView.backgroundColor = background;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshFromServer) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    [self.tableView addSubview: refreshControl];
    
    formatter  = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    formatter.doesRelativeDateFormatting = YES;

    self.managedObjectContext = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    //synchronize
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
   // [[MobileBrokerClient sharedClient] syncActivityInformation];
}

- (void) refreshFromServer {
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"ActivityCell" owner:self options:nil];
        cell = self.activityCell;
        self.activityCell = nil;
    }
    [self configureCell:cell atIndexPath:indexPath];
    // Configure the cell...
    
    return cell;
}

/**
 * Do not allow to move the table order
 */
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

/**
 * Default action when selecting the row
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

/**
 * Creates a new cell for any table
 * we don't really have a cell defined in the interface builder so we load it from a NIB.
 * This keeps the search results and regular cell on the same format.
 */
- (void)configureCell:(ActivityCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if (!cell) return;
    
    if (!formatter){
        formatter  = [[NSDateFormatter alloc] init];
        [formatter setTimeStyle:NSDateFormatterNoStyle];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        formatter.doesRelativeDateFormatting = YES;
    }
    
    DActivity *dactivity = (DActivity *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", dactivity.dpersonInfo.firstName,dactivity.dpersonInfo.lastName ];
    NSLog(@"name = %@",fullName);
    
    cell.ppdFullName.text = fullName;
    cell.ppdPosition.text = dactivity.dpersonInfo.title;
    
    cell.cioFullName.text = [NSString stringWithFormat:@"%@ %@", dactivity.dcioInfo.firstName,dactivity.dcioInfo.lastName ];
    cell.cioTitle.text = dactivity.dcioInfo.title;
    cell.lastUpdated.text = [formatter stringFromDate:dactivity.lastModifiedDate];
    
    /*
     @property (weak, nonatomic) IBOutlet UILabel *ppdFullName;
     @property (weak, nonatomic) IBOutlet UILabel *ppdPosition;
     @property (weak, nonatomic) IBOutlet UILabel *cioFullName;
     @property (weak, nonatomic) IBOutlet UILabel *cioTitle;
     @property (weak, nonatomic) IBOutlet UILabel *lastUpdated;
     @property (weak, nonatomic) IBOutlet UIImageView *ppdImage;
     */
}

/**
 * enable editing on the table content
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}
#pragma mark - slideMenuClient
- (void) registerSlideMenuViewController:(SlideMenuViewController *) slideMenuViewController{
    self.slideMenuViewController = slideMenuViewController;
}

- (IBAction)slideMenuAction:(id)sender{
    [self.slideMenuViewController slideMenu];
}
//

/**
 * default height for the table row
 */
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 114.0;
}

#pragma mark - fetch results controller
- (NSFetchedResultsController *)fetchedResultsController
{
    //we do nothing if we don't have an itinerary to search on
    
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:ACTIVITY_TABLE inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    //Set the predicate to search for the itinerary and searchbar if text is found on the searchbar
    
    NSPredicate *predicate;
    
    if (self.searchString) {
        // predicate that uses searchString (used by UISearchDisplayController)
        // e.g., [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", self.searchString];
        predicate = [NSPredicate predicateWithFormat:@"dpersonInfo.firstName CONTAINS[cd] %@ or dpersonInfo.lastName CONTAINS[cd] %@ ", self.searchString,self.searchString];
    } else {
        // predicate without searchString (used by UITableViewController)
        predicate = nil;
    }
    
    if (predicate)
        [fetchRequest setPredicate:predicate];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastModifiedDate" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
#ifdef DEBUG
	    abort();
#endif
	}
    
    return _fetchedResultsController;
    
}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}


/**
 * Notifies the receiver of the addition or removal of a section.
 *
 * The fetched results controller reports changes to its section before changes to the fetched result objects.
 * This method may be invoked many times during an update event (for example, if you are importing data on a
 * background thread and adding them to the context in a batch).
 * You should consider carefully whether you want to update the table view on receipt of each message.
 */
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:{
            ActivityCell *cell = (ActivityCell *) [tableView cellForRowAtIndexPath:indexPath];
            [self configureCell:cell atIndexPath:indexPath];
        }
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (IBAction)imageTapped:(id)sender {
    [self performSegueWithIdentifier:@"checkInSegue" sender:self];
}
@end
