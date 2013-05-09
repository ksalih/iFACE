//
//  JYTrueEtchedCell.m
//  FieldOps Mobile
//
//  Created by Jorge Carvallo on 3/25/13.
//  Copyright (c) 2013 Deloitte  . All rights reserved.
//

#import "JYTrueEtchedCell.h"
@interface JYTrueEtchedCell ()

@property (strong,nonatomic) UIView *whiteLineView;
@property (strong,nonatomic) UIView *blackLineView;

@end

@implementation JYTrueEtchedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    if (self.whiteLineView){
        [self.whiteLineView removeFromSuperview];
    }
    self.whiteLineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,self.frame.size.width,1.0f)];
    self.whiteLineView.backgroundColor = [UIColor whiteColor];
    self.whiteLineView.alpha = 0.2;
    [self addSubview:self.whiteLineView];
    
    if (self.blackLineView){
        [self.blackLineView removeFromSuperview];
    }
    self.blackLineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,self.frame.size.height-1,self.frame.size.width,1.0f)];
    self.blackLineView.backgroundColor = [UIColor blackColor];
    self.blackLineView.alpha = 0.5;
    [self addSubview:self.blackLineView];
}
@end
