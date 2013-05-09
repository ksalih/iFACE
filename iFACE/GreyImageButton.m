//
//  GreyImageButton.m
//  FieldOps Mobile
//
//  Created by Jorge Carvallo on 9/20/12.
//  Copyright (c) 2012 Deloitte  . All rights reserved.
//

#import "GreyImageButton.h"
/**
 This class uses greyButtonHightlight@2x.png and greyButton@2x.png
 Those two files are required in order to customize this button
 */
@implementation GreyImageButton

-(id) initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        UIImage *buttonImage = [[UIImage imageNamed:@"greyButton.png"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
        UIImage *buttonImageHighlight = [[UIImage imageNamed:@"greyButtonHighlight.png"]
                                         resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
        [self setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [self setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
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

@end
