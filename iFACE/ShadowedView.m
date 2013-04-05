//
//  ShadowedView.m
//  FieldOps Mobile
//
//  Created by Jorge Carvallo on 9/18/12.
//  Copyright (c) 2012 Deloitte for US Department of Transportation Pipeline and Hazardous Materials Safety Administration. All rights reserved.
//

#import "ShadowedView.h"
#import "BackgroundLayer.h"

#define SHADOW_HEIGHT 40.0
#define SHADOW_INVERSE_HEIGHT 20.0
#define SHADOW_RATIO (SHADOW_INVERSE_HEIGHT / SHADOW_HEIGHT)
#define SHADOW_WIDTH  40.0

/**
 A Simple View that overrides methods to add an inner shadow to the view frame
 Remember to set the inital parameters in the setter section of the interface if required
 
 */
@implementation ShadowedView
@synthesize gradientSize,showLeftGradient, showRightGradient;
/**
 Initializes the gradientSize based on the current device's width
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initializa at 3% of the width
        self.gradientSize = self.frame.size.width *.03;
        self.showTopInnerGradient = YES;
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self){
        self.showTopInnerGradient = YES;
        
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

/**
 Manages the subviews to add shadows and other fancy things. 
 The shadow's width is based on the percentage variable (gradientSize), this is also used for the height since all gradietns should have the same width and height (depending on the position)
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    //do we have a custom gradient size? if not, use the default value
    if (gradientSize){
        finalgradientSize = gradientSize;
    }else{
        //no gradientSize, calculate as 6% of the width
        finalgradientSize = self.bounds.size.width * 0.03;
        //save the other value for rotations
        gradientSize = finalgradientSize;
    }
    //do we have topShadow?
    if (self.showTopInnerGradient){
        if (!topShadow){
            topShadow = [BackgroundLayer greyDifuseGradient];
            topShadow.frame = CGRectMake(0, 0, self.bounds.size.width, finalgradientSize);
            [self.layer insertSublayer:topShadow atIndex:0];
        }else if (![[self.layer.sublayers objectAtIndex:0] isEqual:topShadow]){
            [self.layer insertSublayer:topShadow atIndex:0];
        }
    }
    
    if (showLeftGradient){
        if (!leftShadow){
            leftShadow = [BackgroundLayer greyDifuseGradientHorizontal];
            leftShadow.frame = CGRectMake(0, 0, finalgradientSize, self.bounds.size.height) ;
                  [self.layer insertSublayer:leftShadow atIndex:1];
        }else if (![[self.layer.sublayers objectAtIndex:1] isEqual:leftShadow]){
                [self.layer insertSublayer:leftShadow atIndex:1];
        }
    }else{
        //we say no to showThe left gradient but we have it, remove the layer
        if (leftShadow){
            [leftShadow removeFromSuperlayer];
        }
    }
    
    if (self.showLeftOuterGradient) {
        if (!leftOuterShadow){
           leftOuterShadow = [BackgroundLayer greyDifuseGradientHorizontalInverted];
            leftOuterShadow.frame = CGRectMake(-1 * (finalgradientSize), 0, finalgradientSize, self.bounds.size.height) ;
                [self.layer insertSublayer:leftShadow atIndex:0];
            
        }else{
            BOOL layerFound = NO;
            
            for (CALayer *currentLayer in self.layer.sublayers)
                if ([currentLayer isEqual:leftOuterShadow])
                   layerFound = YES;
                   
            
        if (!layerFound)
            [self.layer insertSublayer:leftOuterShadow atIndex:[self.layer.sublayers count]];

        }
    }
    
   

//    if (!bottomShadow){
//        bottomShadow = [BackgroundLayer greyDifuseGradientInverted];
//        bottomShadow.frame = CGRectMake(0, self.bounds.size.height-finalgradientSize, self.bounds.size.width, finalgradientSize);
//        [self.layer insertSublayer:bottomShadow atIndex:1];
//    }else if (![[self.layer.sublayers objectAtIndex:1] isEqual:bottomShadow]){
//        [self.layer insertSublayer:bottomShadow atIndex:1];
//    }
//    
//    if (!leftShadow){
//        leftShadow = [BackgroundLayer greyDifuseGradientHorizontal];
//        leftShadow.frame = CGRectMake(0, 0, finalgradientSize, self.bounds.size.height) ;
//        [self.layer insertSublayer:leftShadow atIndex:2];
//    }else if (![[self.layer.sublayers objectAtIndex:2] isEqual:leftShadow]){
//        [self.layer insertSublayer:leftShadow atIndex:2];
//    }
//    if (!rightShadow){
//        rightShadow = [BackgroundLayer greyDifuseGradientHorizontalInverted];
//        rightShadow.frame = CGRectMake(self.bounds.size.width-finalgradientSize, 0, finalgradientSize, self.bounds.size.height);
//        [self.layer insertSublayer:rightShadow atIndex:3];
//    }else if (![[self.layer.sublayers objectAtIndex:3] isEqual:rightShadow]){
//        [self.layer insertSublayer:rightShadow atIndex:3];
//    }

//    
//    if (!rightShadow){
//        rightShadow = [self generateShadow:CGRectMake(self.frame.size.width-finalgradientSize, 0, finalgradientSize, self.frame.size.height) inverted:YES];
//        
//        [rightShadow setStartPoint:CGPointMake(0, 0.5)];
//        [rightShadow setEndPoint:CGPointMake(1, 0.5)];
//        
//        [self.layer insertSublayer:rightShadow atIndex:3];
//        
//    }else if (![[self.layer.sublayers objectAtIndex:3] isEqual:rightShadow])
//	{
//        [self.layer insertSublayer:rightShadow atIndex:3];
//    }
//    
//    [CATransaction begin];
//	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
//    //
//	// Stretch and place the origin shadow
//	//

//    
//    [CATransaction commit];
    topShadow.frame = CGRectMake(0, 0, self.bounds.size.width, finalgradientSize);
    if (showLeftGradient){
         leftShadow.frame = CGRectMake(0, 0, finalgradientSize, self.bounds.size.height);
    }
    
//    bottomShadow.frame = CGRectMake(0, self.bounds.size.height-finalgradientSize, self.bounds.size.width, finalgradientSize);
//    leftShadow.frame = CGRectMake(0, 0, finalgradientSize, self.bounds.size.height);
//    rightShadow.frame = CGRectMake(self.bounds.size.width-finalgradientSize, 0, finalgradientSize, self.bounds.size.height);
}


- (CAGradientLayer *) generateShadow:(CGRect) frame inverted:(BOOL) inverted{
    CAGradientLayer *newShadow = [CAGradientLayer layer];

    newShadow.frame = frame;
    UIColor *darkColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha: 0.5];
    UIColor *lightColor = [self.backgroundColor colorWithAlphaComponent:0.0];
    
    newShadow.colors = [NSArray arrayWithObjects: inverted?(id)lightColor:(id)darkColor,inverted?(id)darkColor:(id)lightColor, nil];
    //add bottom layer shadow
    return newShadow;
}

@end
