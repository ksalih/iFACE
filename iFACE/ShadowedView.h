//
//  ShadowedView.h
//  FieldOps Mobile
//
//  Created by Jorge Carvallo on 9/18/12.
//  Copyright (c) 2012 Deloitte for US Department of Transportation Pipeline and Hazardous Materials Safety Administration. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
/**
 A view that automatically adds an inner shadow to the border of the view.
 This view doesn't work as the main root view for some reason, the self.frame.width is not being reported correctly after rotating the device
 */
@interface ShadowedView : UIView {
    CAGradientLayer *topShadow, *bottomShadow, *leftShadow, *rightShadow;
    CAGradientLayer *leftOuterShadow;
    float finalgradientSize;
}

@property float gradientSize;
@property BOOL showLeftGradient;
@property BOOL showRightGradient;
@property BOOL showTopInnerGradient;
@property BOOL showLeftOuterGradient;

@end
