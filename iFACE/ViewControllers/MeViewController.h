//
//  MeViewController.h
//  iFACE
//
//  Created by Jorge Carvallo on 4/6/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideMenuViewController.h"

@interface MeViewController : UIViewController <SlideMenuViewControllerClient,NSFetchedResultsControllerDelegate>

@property (strong,nonatomic) SlideMenuViewController *slideMenuViewController;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *slideMenuButton;
@property (weak, nonatomic) IBOutlet UIView *userContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *userPictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titlePositionLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceAreaLabel;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)imageTapped:(id)sender;

- (IBAction)slideMenuAction:(id)sender;

- (void) registerSlideMenuViewController:(SlideMenuViewController *) slideMenuViewController;


@end
