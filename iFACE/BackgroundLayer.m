//
//  BackgroundLayer.m
//  FieldOps Mobile
//
//  Created by Jorge Carvallo on 9/21/12.
//  Copyright (c) 2012 Jylups LLC. All rights reserved.
//

#import "BackgroundLayer.h"
@implementation BackgroundLayer

//Metallic grey gradient background
+ (CAGradientLayer*) greyGradient {
    
    UIColor *colorOne = [UIColor colorWithWhite:0.9 alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.85 alpha:1.0];
    UIColor *colorThree = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.7 alpha:1.0];
    UIColor *colorFour = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.4 alpha:1.0];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, colorThree.CGColor, colorFour.CGColor, nil];
    
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:0.02];
    NSNumber *stopThree = [NSNumber numberWithFloat:0.99];
    NSNumber *stopFour = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, stopThree, stopFour, nil];
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    return headerLayer;
    
}

//Blue gradient background
+ (CAGradientLayer*) blueGradient {
    
    UIColor *colorOne = [UIColor colorWithRed:(120/255.0) green:(135/255.0) blue:(150/255.0) alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:(57/255.0) green:(79/255.0) blue:(96/255.0) alpha:1.0];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    return headerLayer;
    
}

+ (CAGradientLayer*) greyDifuseGradient {
    
    UIColor *colorOne = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha: 0.7];
    UIColor *colorTwo = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha: 0.0];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    return headerLayer;
    
}

+ (CAGradientLayer*) greyDifuseGradientInverted {
    
    UIColor *colorOne = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha: 0.0];
    UIColor *colorTwo = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha: 0.5];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    return headerLayer;
    
}

+ (CAGradientLayer*) greyDifuseGradientHorizontal {
    
    UIColor *colorOne = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha: 0.5];
    UIColor *colorTwo = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha: 0.0];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    headerLayer.startPoint = CGPointMake(0, 0.5);
    headerLayer.endPoint = CGPointMake(1, 0.5);
    
    return headerLayer;
    
}

+ (CAGradientLayer*) greyDifuseGradientHorizontalPageStyle {
    
    UIColor *colorOne = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha: 0.4];
    UIColor *colorTwo = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha: 0.1];
    UIColor *colorThree = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha: 0.0];

    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, colorThree.CGColor,colorThree.CGColor,nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:0.1];

    NSNumber *stopThree = [NSNumber numberWithFloat:0.5];
    NSNumber *stopFour = [NSNumber numberWithFloat:1.0];

    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, stopThree, stopFour, nil];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    headerLayer.startPoint = CGPointMake(0, 0.5);
    headerLayer.endPoint = CGPointMake(1, 0.5);
    
    return headerLayer;
    
}

+ (CAGradientLayer*) greyDifuseGradientHorizontalInverted {
    
    UIColor *colorOne = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha: 0.0];
    UIColor *colorTwo = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha: 0.5];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    headerLayer.startPoint = CGPointMake(0, 0.5);
    headerLayer.endPoint = CGPointMake(1, 0.5);
    
    return headerLayer;
    
}

+ (CAGradientLayer*) lightHighlightGradient {
    UIColor *colorOne = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha: 0.0];
    UIColor *colorTwo = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha: 0.5];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    headerLayer.startPoint = CGPointMake(0, 0.5);
    headerLayer.endPoint = CGPointMake(1, 0.5);
    
    return headerLayer;
}

+ (CAGradientLayer*) lightHighlightGradientHorizontalWithAlpha:(float) alpha {
    UIColor *colorOne = [UIColor colorWithRed:1 green:1 blue:1 alpha: alpha];
    UIColor *colorTwo = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha: alpha];
    UIColor *colorThree = [UIColor colorWithRed:0 green:0 blue:0 alpha: alpha];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, colorThree.CGColor,nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:0.5];
    NSNumber *stopThree = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, stopThree, nil];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    return headerLayer;
}

@end

