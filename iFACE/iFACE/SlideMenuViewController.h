//
//  ViewController.h
//  SlideMenuSample
//
//  Created by Jorge Carvallo on 3/25/13.
//  Copyright (c) 2013 jylups LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShadowedView.h" 

//constant classes
#ifndef ShadowedView_h
#define ShadowedView_h

//extern NSString * const SMMMasterSegue = @"masterSegue";
//extern NSString * const SMSideMenuSegue = @"sideMenuSegue";

extern NSString * const SMMMasterSegue;
extern NSString * const SMSideMenuSegue;

#endif
@class SlideMenuViewController;

@protocol SlideMenuViewControllerClient <NSObject>
/**
 * This method is called when the slider menu wants to register to a view controller. 
 * 
 */
- (void) registerSlideMenuViewController:(SlideMenuViewController *) slideMenuViewController;
@end

@interface SlideMenuViewController : UIViewController <UIGestureRecognizerDelegate>

@property (strong,nonatomic) IBOutlet ShadowedView *containerController;
@property (strong,nonatomic) IBOutlet UIPanGestureRecognizer *panGestureRecognizer;

- (IBAction)panAction:(UIPanGestureRecognizer *)sender;
- (void) slideMenu;
//don't keep strong references to the view controllers
@property (weak,nonatomic) UIViewController *masterViewController;
@property (weak,nonatomic) UIViewController *sideViewController;

@end
