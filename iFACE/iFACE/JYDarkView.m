//
//  JYDarkView.m
//  FieldOps Mobile
//
//  Created by Jorge Carvallo on 1/28/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import "JYDarkView.h"
#import <QuartzCore/QuartzCore.h>

@implementation JYDarkView

+ (id)createDarkView:(CGRect) bounds
{
    JYDarkView *loadingView =
    [[JYDarkView alloc] initWithFrame:bounds];
	if (!loadingView)
	{
		return nil;
	}
	
	loadingView.opaque = YES;
	loadingView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    loadingView.backgroundColor = [UIColor blackColor];
    loadingView.alpha = 0.5;
	// Set up the fade-in animation
    
	
	return loadingView;
}
//
// removeView
//
// Animates the view out from the superview. As the view is removed from the
// superview, it will be released.
//
- (void)removeView:(BOOL) animated
{
	UIView *aSuperview = [self superview];
	[super removeFromSuperview];
    
    if (animated){
	// Set up the animation
        CATransition *animation = [CATransition animation];
        [animation setType:kCATransitionFade];
	
        [[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
    }
}

@end
