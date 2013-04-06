//
//  JYGraphicsHelper.h
//  FieldOps Mobile
//
//  Created by Jorge Carvallo on 1/15/13.
//  Copyright (c) 2013 Jylups LLC. All rights reserved.
// A set of graphic enhancements used across the application
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "JYDarkView.h"

@interface JYGraphicsHelper : NSObject

+ (void) roundlayer:(CALayer *) layer withRadius:(float) radius;
+ (JYDarkView *) addDarkView:(UIView *)view animated:(BOOL) animated;
+ (void) addRoundCornersToLayer:(CALayer *)layer withRadious:(float)radious;
+ (void) addShadowAndRoundCornersToLayer:(CALayer *)layer withRadious:(float)radious;

@end
