//
//  MeViewController.m
//  iFACE
//
//  Created by Jorge Carvallo on 4/6/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import "MeViewController.h"
#import "JYGraphicsHelper.h" 
#import "AppDefinitions.h"
#import "ApplicationPreferences.h"
#import "AppDelegate.h"

@implementation MeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"TableBG"]];
    self.view.backgroundColor = background;
    [JYGraphicsHelper addShadowAndRoundCornersToLayer:self.userContainerView.layer withRadious:5];
    self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    if ([[self.fetchedResultsController fetchedObjects] count] >0 ) {
        self.user = [[self.fetchedResultsController fetchedObjects] objectAtIndex:0];
        [self updateUserUIComponent:self.user];

    }

}

- (void) updateUserUIComponent:(DPerson *)person {
    /*
     @property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
     @property (weak, nonatomic) IBOutlet UILabel *titlePositionLabel;
     @property (weak, nonatomic) IBOutlet UILabel *locationLabel;
     @property (weak, nonatomic) IBOutlet UILabel *serviceAreaLabel;
     */
    
    self.fullNameLabel.text = [NSString stringWithFormat:@"%@ %@",person.firstName,person.lastName];
    self.titlePositionLabel.text = person.title;
    self.locationLabel.text = [NSString stringWithFormat:@"%@, %@",person.city, person.state];
    self.serviceAreaLabel.text = person.serviceArea;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   }

- (void) registerSlideMenuViewController:(SlideMenuViewController *) slideMenuViewController{
    self.slideMenuViewController = slideMenuViewController;
}

#pragma mark - actions
- (IBAction)imageTapped:(id)sender {
    if (sender == self.userPictureImageView){
        
    }else{
        [self performSegueWithIdentifier:@"checkInSegue" sender:self];
    }
}

- (IBAction)slideMenuAction:(id)sender{
    [self.slideMenuViewController slideMenu];
}
#pragma mark - fetchedResultsController delegate

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
            
            //self.user = (DPerson *)anObject;
            [self updateUserUIComponent:(DPerson *)anObject];
//            self.userNameLabel.text = [NSString stringWithFormat:@"%@ %@",self.user.firstName,self.user.lastName];
            break;
            
        case NSFetchedResultsChangeMove:
            
            break;
    }
}

@end
