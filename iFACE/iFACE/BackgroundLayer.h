//
//  BackgroundLayer.h
//  FieldOps Mobile
//
//  Created by Jorge Carvallo on 9/21/12.
//  Copyright (c) 2012 Jylups LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface BackgroundLayer : NSObject

+(CAGradientLayer*) greyGradient;
+(CAGradientLayer*) blueGradient;
+(CAGradientLayer*) greyDifuseGradient;
+(CAGradientLayer*) greyDifuseGradientInverted;
+(CAGradientLayer*) greyDifuseGradientHorizontal;
+(CAGradientLayer*) greyDifuseGradientHorizontalInverted;
+ (CAGradientLayer*) greyDifuseGradientHorizontalPageStyle;
+ (CAGradientLayer*) lightHighlightGradientHorizontalWithAlpha:(float) alpha;

@end