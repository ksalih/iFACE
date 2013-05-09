//
//  CIOProfileViewController.h
//  iFACE
//
//  Created by Jorge Carvallo on 4/7/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCIO.h"
#import "SlideMenuViewController.h"

@interface CIOProfileViewController : UIViewController

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) DCIO *selectedCIO;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *agencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityStateLabel;
@property (weak, nonatomic) SlideMenuViewController *slideMenuViewController;

- (void) registerSlideMenuViewController:(SlideMenuViewController *) slideMenuViewController;

@end
