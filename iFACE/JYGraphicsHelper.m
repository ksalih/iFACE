//
//  JYGraphicsHelper.m
//  FieldOps Mobile
//
//  Created by Jorge Carvallo on 1/15/13.
//  Copyright (c) 2013 Jylups LLC. All rights reserved.
//

#import "JYGraphicsHelper.h"
#import <QuartzCore/QuartzCore.h>
#import "JYDarkView.h"

@implementation JYGraphicsHelper


+ (void) roundlayer:(CALayer *) layer withRadius:(float)radius{
    layer.cornerRadius = radius;
    layer.borderWidth = 1;
    layer.borderColor = [UIColor lightGrayColor].CGColor;
    layer.shadowColor = [UIColor whiteColor].CGColor;
    layer.shadowOffset = CGSizeMake(0,1);
    
}

+ (JYDarkView *) addDarkView:(UIView *)view animated:(BOOL) animated{
    JYDarkView *loadingView = [JYDarkView createDarkView:view.bounds];
    [view addSubview:loadingView];
    
    if (animated){
        CATransition *animation = [CATransition animation];
        [animation setType:kCATransitionFade];
        [[view layer] addAnimation:animation forKey:@"layerAnimation"];
    }
    return loadingView;
}

@end
