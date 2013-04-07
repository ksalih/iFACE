//
//  CompleteCheckInViewController.m
//  iFACE
//
//  Created by Jorge Carvallo on 4/7/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import "CompleteCheckInViewController.h"
#import "JYGraphicsHelper.h"
#import "AppDelegate.h"
#import "AppDefinitions.h"
#import "DActivity.h"
#import "IFACECoredataHelper.h"
#import "DPerson.h"
#import "ApplicationPreferences.h" 

@implementation CompleteCheckInViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"TableBG"]];
    self.view.backgroundColor = background;
    
    [JYGraphicsHelper addShadowAndRoundCornersToLayer:self.textView.layer withRadious:8];
    self.checkinMessageLabel.text = [NSString stringWithFormat:@"Checking with %@ %@",self.selectedCIO.firstName,self.selectedCIO.lastName];
    
    self.managedObjectContext = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkInAction:(id)sender {
    
    DPerson *mePerson = [IFACECoredataHelper getDPersonByEmail:[ApplicationPreferences applicationUser] withManagedObjectContext:self.managedObjectContext];
    DActivity *myActivity;
    
    myActivity = [NSEntityDescription insertNewObjectForEntityForName:ACTIVITY_TABLE inManagedObjectContext:self.managedObjectContext];
    
    myActivity.activityType = @"CHECKIN";
    myActivity.dcioInfo = self.selectedCIO;
    myActivity.geoLat = [NSNumber numberWithDouble:self.seletedVenue.coordinate.latitude];
    myActivity.geoLong = [NSNumber numberWithDouble:self.seletedVenue.coordinate.longitude];
    myActivity.message = self.messageTextView.text;
    myActivity.venue = self.seletedVenue.name;
    myActivity.lastModifiedDate = [NSDate date];
    
    myActivity.dpersonInfo = mePerson;
    
    NSError *error;
    if (![self.managedObjectContext save:&error]){
        //TODO: Do something with the error
        NSLog(@"Error saving activity");
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    /**
     @dynamic activityType;
     @dynamic badgeAwarded;
     @dynamic badgeType;
     @dynamic dCIO;
     @dynamic dPerson;
     @dynamic geoLat;
     @dynamic geoLong;
     @dynamic message;
     @dynamic remoteID;
     @dynamic venue;
     @dynamic lastModifiedDate;
     @dynamic dcioInfo;
     @dynamic dpersonInfo;
     */
    
}
@end
