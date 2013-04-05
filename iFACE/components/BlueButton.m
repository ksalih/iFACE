//
//  BlueButton.m
//  iFACE
//
//  Created by Jorge Carvallo on 4/5/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import "BlueButton.h"

@implementation BlueButton

-(id) initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        UIImage *buttonImage = [[UIImage imageNamed:@"BlueButton.png"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
        UIImage *buttonImageHighlight = [[UIImage imageNamed:@"BlueButtonHighlighted.png"]
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
