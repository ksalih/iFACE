//
//  JYLoadingView.h
//
//  This file is part of the Jylups LLC application common framework
//
//  Created by Jorge Carvallo on 11/9/12.
//  Copyright (c) 2012 Jylups LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYLoadingView : UIView
{
    
}
CGPathRef NewPathWithRoundRect(CGRect rect, CGFloat cornerRadius);

+ (id)loadingViewInView:(UIView *)aSuperview;
- (void)removeView;
+ (id)createLoadingView:(CGRect) bounds;
+ (id) createLoadingView:(CGRect)bounds withMessage:(NSString *)message;

@end

