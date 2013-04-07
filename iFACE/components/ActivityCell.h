//
//  ActivityCell.h
//  iFACE
//
//  Created by Jorge Carvallo on 4/7/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ppdFullName;
@property (weak, nonatomic) IBOutlet UILabel *ppdPosition;
@property (weak, nonatomic) IBOutlet UILabel *cioFullName;
@property (weak, nonatomic) IBOutlet UILabel *cioTitle;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdated;
@property (weak, nonatomic) IBOutlet UIImageView *ppdImage;
@property (weak,nonatomic) IBOutlet UILabel *activityName;
@end
