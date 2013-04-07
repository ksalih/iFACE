//
//  CheckInViewController.h
//  iFACE
//
//  Created by Jorge Carvallo on 4/6/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Foursquare2.h"
#import "FSVenue.h"
#import "FSConverter.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface CheckInViewController : UIViewController <CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>{
    CLLocationManager *_locationManager;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong,nonatomic)NSArray* nearbyVenues;

@end
