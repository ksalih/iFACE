//
//  CIOProfileViewController.m
//  iFACE
//
//  Created by Jorge Carvallo on 4/7/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import "CIOProfileViewController.h"

@interface CIOProfileViewController ()

@end

@implementation CIOProfileViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"TableBG"]];
    self.view.backgroundColor = background;
    
    self.fullNameLabel.text = [NSString stringWithFormat:@"%@ %@",self.selectedCIO.firstName,self.selectedCIO.lastName];
    self.titleLabel.text = self.selectedCIO.title;
    self.agencyLabel.text = self.selectedCIO.agency;
    //self.cityStateLabel.text = [NSString stringWithFormat:@"%@ %@",self.selectedCIO.];
    
    /*
     @property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
     
     @property (weak, nonatomic) IBOutlet UILabel *titleLabel;
     @property (weak, nonatomic) IBOutlet UILabel *agencyLabel;
     @property (weak, nonatomic) IBOutlet UILabel *cityStateLabel;
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
