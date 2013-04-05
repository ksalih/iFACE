//
//  JYDarkView.h
//  FieldOps Mobile
//
//  Created by Jorge Carvallo on 1/28/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYDarkView : UIView

- (void)removeView:(BOOL) animated;
+ (id)createDarkView:(CGRect) bounds;

@end
