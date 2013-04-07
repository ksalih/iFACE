//
//  CompleteCheckInViewController.h
//  iFACE
//
//  Created by Jorge Carvallo on 4/7/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "DCIO.h"
#import "FSVenue.h"

@interface CompleteCheckInViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak,nonatomic) IBOutlet UIView *textView;
@property (strong,nonatomic) DCIO *selectedCIO;
@property (strong,nonatomic) FSVenue *seletedVenue;
@property (weak, nonatomic) IBOutlet UILabel *checkinMessageLabel;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)checkInAction:(id)sender;

@end
