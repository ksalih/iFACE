//
//  CIOPickViewController.m
//  iFACE
//
//  Created by Jorge Carvallo on 4/6/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import "CIOPickViewController.h"
#import "AppDefinitions.h"
#import "AppDelegate.h"
#import "MobileBrokerClient.h"
#import "NSString+FetchedGroupByString.h"
#import "CompleteCheckInViewController.h" 

@interface CIOPickViewController ()
@property (strong,nonatomic) DCIO *selectedDCIO;
@end

@implementation CIOPickViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"TableBG"]];
    self.view.backgroundColor = background;

    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshFromServer) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    [self.tableView addSubview: refreshControl];

	// Do any additional setup after loading the view.
    self.title = self.venue.name;
    self.managedObjectContext = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    [[MobileBrokerClient sharedClient] syncCIOInformation];
}

- (void) refreshFromServer {
    [self.refreshControl endRefreshing];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
    
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
    self.selectedDCIO = (DCIO *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"compleCheckInSegue" sender:self];
}
/**
 * enable editing on the table content
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo name];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#",nil];
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    //we do nothing if we don't have an itinerary to search on
    
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:CIO_TABLE inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    //Set the predicate to search for the itinerary and searchbar if text is found on the searchbar
    
    NSPredicate *predicate;
    
    if (self.searchString) {
        // predicate that uses searchString (used by UISearchDisplayController)
        // e.g., [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", self.searchString];
        predicate = [NSPredicate predicateWithFormat:@"firstName CONTAINS[cd] %@ or lastName CONTAINS[cd] %@ ", self.searchString,self.searchString];
    } else {
        // predicate without searchString (used by UITableViewController)
        predicate = nil;
    }
    
    if (predicate)
        [fetchRequest setPredicate:predicate];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"firstName.stringGroupByFirstInitial" cacheName:nil];
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

/**
 * Creates a new cell for any table
 * we don't really have a cell defined in the interface builder so we load it from a NIB.
 * This keeps the search results and regular cell on the same format.
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    DCIO *dcio = (DCIO *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",dcio.firstName,dcio.lastName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",dcio.title,dcio.agency];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}
//

/**
 * This gets called when the user starts typing text into the search bar
 */
-(BOOL)searchDisplayController:(UISearchDisplayController *)_controller shouldReloadTableForSearchString:(NSString *)localSearchString {
    self.searchString = localSearchString;
    self.fetchedResultsController = nil;
    return YES;
}

/** This gets called when user cancels or closes the search bar */
-(void)searchDisplayController:(UISearchDisplayController *)controller willUnloadSearchResultsTableView:(UITableView *)tableView {
    self.searchString = nil;
    self.fetchedResultsController = nil;
    [self.tableView reloadData];
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
            UITableViewCell *cell = (UITableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
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

#pragma mark - navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"compleCheckInSegue"]){
        CompleteCheckInViewController *completeCheckInViewController = (CompleteCheckInViewController *) segue.destinationViewController;
        completeCheckInViewController.seletedVenue = self.venue;
        completeCheckInViewController.selectedCIO = self.selectedDCIO;
    }
}

/** This gets called when user cancels or closes the search bar */


@end
