//
//  CIOSearchViewController.m
//  iFACE
//
//  Created by Jorge Carvallo on 4/7/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import "CIOSearchViewController.h"

@interface CIOSearchViewController ()

@end

@implementation CIOSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"TableBG"]];
//    self.tableView.backgroundColor = background;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshFromServer) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    [self.tableView addSubview: refreshControl];

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
    
}
- (IBAction)slideMenuAction:(id)sender {
    [self.slideMenuViewController slideMenu];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"compleCheckInSegue"]){
        CIOProfileViewController *cioProfileViewController = (CIOProfileViewController *)[segue destinationViewController];
        cioProfileViewController.selectedCIO = self.selectedDCIO;
    }
}
@end
