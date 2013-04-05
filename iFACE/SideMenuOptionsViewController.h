//
//  SideMenuOptionsViewController.h
//  FieldOps Mobile
//
//  Created by Jorge Carvallo on 3/25/13.
//  Copyright (c) 2013 Deloitte for US Department of Transportation Pipeline and Hazardous Materials Safety Administration. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "JYDarkTranslucentCellHeaderView.h"
#import "SlideMenuViewController.h"

@interface SideMenuOptionsViewController : UITableViewController <SlideMenuViewControllerClient,NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (strong,nonatomic) IBOutlet JYDarkTranslucentCellHeaderView *jyDarkTranslucentCellHeaderView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
