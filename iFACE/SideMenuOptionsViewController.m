//
//  SideMenuOptionsViewController.m
//  FieldOps Mobile
//
//  Created by Jorge Carvallo on 3/25/13.
//  Copyright (c) 2013 Deloitte for US Department of Transportation Pipeline and Hazardous Materials Safety Administration. All rights reserved.
//

#import "SideMenuOptionsViewController.h"
#import "ApplicationPreferences.h"
#import "AppDelegate.h"
#import "ChangeUserInfoViewController.h"
#import "AppDefinitions.h"
#import "DPerson.h"

NSInteger const SideMenuOptionsActionUser = 0;
NSInteger const SideMenuOptionsActionSettings = 0;
NSInteger const SideMenuOptionsActionLogout = 1;

NSInteger const SideMenuOptionsSectionUserActions = 1;
NSInteger const SideMenuOptionsSectionUser = 0;

@interface SideMenuOptionsViewController () 
@property (strong,nonatomic) DPerson *user;
@end

@implementation SideMenuOptionsViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    if ([[self.fetchedResultsController fetchedObjects] count] >0 ) {
        self.user = [[self.fetchedResultsController fetchedObjects] objectAtIndex:0];
        self.userNameLabel.text = [NSString stringWithFormat:@"%@ %@",self.user.firstName,self.user.lastName];
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section ==0)
        return 0;
    else
        return 29;
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    [[NSBundle mainBundle] loadNibNamed:@"JYDarkTranslucentCellHeaderView" owner:self options:nil];
    JYDarkTranslucentCellHeaderView *header = self.jyDarkTranslucentCellHeaderView;
    
    self.jyDarkTranslucentCellHeaderView = nil;
    switch (section){
        case 0:
            header.headerText.text =   @"";          //user Section - no need
            break;
        case 1:
            header.headerText.text = @"User Actions";
            break;
    }
    
    return header;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //Always hide the top menu if the parent is a SlideMenuViewController
    if ([self.parentViewController isKindOfClass:[SlideMenuViewController class]]){
        NSLog(@"Our Poppa is a slideMenuController");
        SlideMenuViewController *slideMenuViewController = (SlideMenuViewController *)self.parentViewController;
        [slideMenuViewController slideMenu];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   switch (indexPath.section) {
       case SideMenuOptionsActionUser:
            [self.slideMenuViewController switchMasterToStoryboardID:@"userProfileStoryBoard"];
           break;
       case SideMenuOptionsSectionUserActions:
            switch (indexPath.row) {
                case 0://activity
                    [self.slideMenuViewController switchMasterToStoryboardID:@"activityStoryboard"];
//                case SideMenuOptionsActionLogout:{
//                    //pop ups an alert
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Logout"
//                                                                        message:@"Would you like to log out of the  application?"
//                                                                       delegate:self
//                                                              cancelButtonTitle:NSLocalizedString(@"Yes", nil)
//                                                              otherButtonTitles:NSLocalizedString(@"No", nil), nil];
//                    [alertView show];
//                }
                    break;
           }
            break;
//            
//        default:
//            break;
   }
    
}
#pragma mark - Alert Delegates

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self performSegueWithIdentifier:LOGIN_SEGUE sender:self];
            break;
        case 1:
           
            break;
        default:
            break;
    }
}

#pragma mark - Table view delegate
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqual:@"userDetailsSegue"]){
//        UINavigationController *navigationViewController = (UINavigationController *) segue.destinationViewController;
//        
//        ChangeUserInfoViewController *changeUserInfoViewController = (ChangeUserInfoViewController *) navigationViewController.topViewController;
//        
//        changeUserInfoViewController.currentUser = self.user;
//        
//    }
}
/**
 */
- (void) registerSlideMenuViewController:(SlideMenuViewController *) slideMenuViewController{
    self.slideMenuViewController = slideMenuViewController;
}

- (NSFetchedResultsController *)fetchedResultsController
{
    //we do nothing if we don't have an itinerary to search on
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:USERS_TABLE inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    //Set the predicate to search for the itinerary and searchbar if text is found on the searchbar
    
    NSPredicate *predicate;
    predicate = [NSPredicate predicateWithFormat:@"email =[cd] %@ ", [ApplicationPreferences applicationUser]];
    
    [fetchRequest setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"email" ascending:NO]]];
    
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    
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

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            
            break;
            
        case NSFetchedResultsChangeDelete:
            
            break;
            
        case NSFetchedResultsChangeUpdate:
            self.user = [[self.fetchedResultsController fetchedObjects] objectAtIndex:0];
            self.userNameLabel.text = [NSString stringWithFormat:@"%@ %@",self.user.firstName,self.user.lastName];
            break;
            
        case NSFetchedResultsChangeMove:
            
            break;
    }
}

@end
