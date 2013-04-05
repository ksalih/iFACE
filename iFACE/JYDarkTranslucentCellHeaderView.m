//
//  JYDarkTranslucentCellHeaderView.m
//  iControlU
//
//  Created by Jorge Carvallo on 11/14/12.
//  Copyright (c) 2012 jylups. All rights reserved.
//

#import "JYDarkTranslucentCellHeaderView.h"
#import "BackgroundLayer.h"

@interface JYDarkTranslucentCellHeaderView ()
@property (strong,nonatomic) UIView *whiteLineView;
@property (strong,nonatomic) UIView *blackLineView;
@property (strong,nonatomic) CAGradientLayer *backgroundGradient;
@end

@implementation JYDarkTranslucentCellHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
        //self.layer.borderColor= [[UIColor alloc]initWithRed:1 green:1 blue:1 alpha:0.4].CGColor;
        //self.layer.borderWidth=1;
    if (self.whiteLineView){
        [self.whiteLineView removeFromSuperview];
    }
    self.whiteLineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,1.0f,self.frame.size.width,1.0f)];
    self.whiteLineView.backgroundColor = [UIColor whiteColor];
    self.whiteLineView.alpha = 0.1;
    [self addSubview:self.whiteLineView];
    
    if (self.blackLineView){
        [self.blackLineView removeFromSuperview];
    }
    self.blackLineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,self.frame.size.height-1,self.frame.size.width,1.0f)];
    self.blackLineView.backgroundColor = [UIColor blackColor];
    self.blackLineView.alpha = 0.7;
    [self addSubview:self.blackLineView];
    
    if (!self.backgroundGradient){
        self.backgroundGradient = [BackgroundLayer lightHighlightGradientHorizontalWithAlpha:0.2];
        self.backgroundGradient.frame = self.bounds;
    }else{
        [self.backgroundGradient removeFromSuperlayer];
    }
    
    [self.layer addSublayer:self.backgroundGradient];
    
}
@end
