//
//  ViewController.m
//  SlideMenuSample
//
//  Created by Jorge Carvallo on 3/25/13.
//  Copyright (c) 2013 jylups LLC. All rights reserved.
//

#import "SlideMenuViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "JYDarkView.h"
#import "JYGraphicsHelper.h" 


NSString * const SMMMasterSegue = @"masterSegue";
NSString * const SMSideMenuSegue =@"sideMenuSegue";

@interface SlideMenuViewController ()
@property (nonatomic) NSInteger slideAmount;
@end

@implementation SlideMenuViewController {
    BOOL slideRight;
    JYDarkView *darkView;
    CGPoint initContainerCenter;
    CGFloat initialAlpha;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    slideRight = YES;
    
    self.containerController.showTopInnerGradient = NO;
    self.containerController.showLeftOuterGradient = YES;
    self.slideAmount = 280;
}

- (void) viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) viewDidAppear:(BOOL)animated {
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectOrientation) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 * When the user pans on the dark View
 */
- (IBAction)panAction:(UIPanGestureRecognizer *)sender {
       
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:darkView];
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        initContainerCenter = self.containerController.center;
        initialAlpha = darkView.alpha;
    }
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged){
    
        
        CGFloat nextContainerX = initContainerCenter.x + translatedPoint.x;
        CGPoint nextContainerPoint = CGPointMake(nextContainerX, initContainerCenter.y);
        
        self.containerController.center = nextContainerPoint;
        //add edge resitance
        if (self.containerController.center.x < (self.containerController.frame.size.width / 2))
            self.containerController.center = CGPointMake((self.containerController.frame.size.width / 2),self.containerController.center.y);
        
        if (self.containerController.center.x > (self.containerController.frame.size.width / 2) + self.slideAmount)
            self.containerController.center = CGPointMake((self.containerController.frame.size.width / 2)+self.slideAmount,self.containerController.center.y);
        //calculate alpha based on the location, we have 0.5 and 320 points to go. Use the frame X location
        CGFloat percentage = (self.containerController.frame.origin.x * 100) / self.slideAmount;
       // NSLog(@"Percentage = %f",percentage);
        CGFloat newAlpha = (initialAlpha * percentage) / 100;
        //NSLog(@"New alpha = %f",newAlpha);
        
        darkView.alpha = newAlpha;
    }
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded){
        initContainerCenter = self.containerController.center;
        if (self.containerController.frame.origin.x <self.slideAmount){
            [self slideMenu];
        }
    }
}

- (void) slideMenu
{
    
    if (slideRight){
        //NSLog(@"initial center for container (%f,%f)",self.containerController.center.x,self.containerController.center.y);
        
        darkView=[JYGraphicsHelper addDarkView:self.containerController animated:NO];
        
        //NSLog(@"Initial Center for darkView (%f,%f)",darkView.center.x,darkView.center.y);
        
        [darkView addGestureRecognizer:self.panGestureRecognizer];
        
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             CGRect navBarFrame = self.containerController.frame;
                             navBarFrame.origin.x += self.slideAmount + 15;
                             self.containerController.frame = navBarFrame;
                             darkView.alpha =0.5;
                             
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.05
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveEaseInOut
                                              animations:^{
                                                  CGRect navBarFrame = self.containerController.frame;
                                                  navBarFrame.origin.x -= 15;
                                                  self.containerController.frame = navBarFrame;
                                                  darkView.alpha =0.5;
                                                }
                                              completion:^(BOOL finished) {
                                                  
                                              }];
                         }];

    }else{
        //calculate based on the current location
        CGFloat distanceToZero = self.containerController.frame.origin.x;
        
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             CGRect navBarFrame = self.containerController.frame;
                             navBarFrame.origin.x -= distanceToZero;
                             self.containerController.frame = navBarFrame;
                             darkView.alpha =0.0;
                         }
                         completion:^(BOOL finished) {
                             [darkView removeFromSuperview];
                             darkView = nil;
                         }];
    }
    slideRight = !slideRight;
}

/**
 */
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   //pass ourselves as the slide menu
    if ([segue.identifier isEqualToString:SMMMasterSegue]){
        
        /* **** split view controller ****/
        if ([[segue destinationViewController] isKindOfClass:[UISplitViewController class]]){
            
            UISplitViewController *splitViewController = (UISplitViewController *) [segue destinationViewController];
            //Get the main menu, check if we have a navigationViewController embeded in
            if ([[splitViewController.viewControllers objectAtIndex:0] isKindOfClass:[UINavigationController class]]){
                UINavigationController *navigationController = [splitViewController.viewControllers objectAtIndex:0];
                self.masterViewController = navigationController.topViewController;
            }else{
                self.masterViewController = [splitViewController.viewControllers objectAtIndex:0];
            }
        }
        
        if ([[segue destinationViewController] isKindOfClass:[UINavigationController class]]){
            UINavigationController *navigationController = (UINavigationController *) segue.destinationViewController;
            self.masterViewController = navigationController.topViewController;
        }
        
        //Check if the main controller that was found conforms to the protocol
        if ([self.masterViewController conformsToProtocol:@protocol(SlideMenuViewControllerClient)]){
            id <SlideMenuViewControllerClient> slideMenuViewController = (id <SlideMenuViewControllerClient>) self.masterViewController;
            [slideMenuViewController registerSlideMenuViewController:self];
        }
    }
    //pass ourselves to the side menu
    if ([segue.identifier isEqualToString:SMSideMenuSegue]){
        if ([[segue destinationViewController] isKindOfClass:[UINavigationController class]]){
            self.sideViewController = [(UINavigationController *) [segue destinationViewController] topViewController];
        }else {
            self.sideViewController = [segue destinationViewController];
        }
        
        if ([self.sideViewController conformsToProtocol:@protocol(SlideMenuViewControllerClient)]){
            id <SlideMenuViewControllerClient> slideMenuViewController = (id <SlideMenuViewControllerClient>) self.sideViewController;
            [slideMenuViewController registerSlideMenuViewController:self];
        }
        
    }
}

#pragma mark - Utility and miscellaneous methods

-(void) detectOrientation {
    //A change in orientation resets the original view
//    if (!slideRight){
//        [self slideMenu];
//    }
    slideRight = YES;
}

- (void) switchMasterToStoryboardID:(NSString *) storyBoardID {
    UIViewController *destViewController =  [self.storyboard instantiateViewControllerWithIdentifier:storyBoardID];
    
    
    if ([destViewController isKindOfClass:[UINavigationController class]]){
        UINavigationController *navigationController = (UINavigationController *) destViewController;
        destViewController = navigationController.topViewController;
        
    }
    
    self.sideViewController = destViewController;
    if ([self.sideViewController conformsToProtocol:@protocol(SlideMenuViewControllerClient)]){
        id <SlideMenuViewControllerClient> slideMenuViewController = (id <SlideMenuViewControllerClient>) self.sideViewController;
        [slideMenuViewController registerSlideMenuViewController:self];
    }
    
    
    //if (destViewController.navigationController != self.masterViewController.navigationController){
       // [self addChildViewController:destViewController];
    UINavigationController *navigation = self.masterViewController.navigationController;
        
    navigation.viewControllers = @[destViewController];
    self.masterViewController = destViewController;
        //[self moveToNewController:destViewController fromController:self.masterViewController.navigationController];
        
    //}
}

-(void)moveToNewController:(UIViewController *) newController fromController:(UIViewController *) currentVC {
  
//[currentVC willMoveToParentViewController:nil];
//    [UIView
//     transitionFromView:self.containerController toView:newController.view
//     duration:0.6 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished){
//        self.containerController = newController.view;
//    }];
    //self.containerController = newController.view;
//    [self transitionFromViewController:currentVC toViewController:newController duration:.6 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{}
//                            completion:^(BOOL finished) {
//                                [currentVC removeFromParentViewController];
//                                [newController didMoveToParentViewController:self];
//                                 //self.masterViewController = newController;
//                            }];
}

@end
