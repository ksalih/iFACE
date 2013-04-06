//
//  MobileBrokerClient.h
//  iFACE
//
//  Created by Jorge Carvallo on 4/6/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zkSforceClient.h"
#import "DPerson.h" 

@class MobileBrokerClient;

typedef enum {
    MobileBrokerClientErrorUserNotFound,
    MobileBrokerClientErrorCount
} MobileBrokerClientErrorCodes;


@protocol MobileBrokerClientDelegate <NSObject>

- (void) mobileBrokerClient:(MobileBrokerClient *)caller didFinishLoginWithClient:(ZKSforceClient *) client;
- (void) mobileBrokerClient:(MobileBrokerClient *)caller didFailTransaction:(MobileBrokerClientErrorCodes) errorCode;
@optional

-(void) mobileBrokerClient:(MobileBrokerClient *)caller didFinishSynchronizingUser:(DPerson *) person;

@end


@interface MobileBrokerClient : NSObject


#pragma mark - Login Information
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *password;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) ZKSforceClient *client;
@property (nonatomic, strong) ZKQueryResult  *results;
@property (weak,nonatomic) id<MobileBrokerClientDelegate> delegate;
//singleton class
+ (MobileBrokerClient *)sharedClient;
- (NSError *) login:(NSString *) userName password:(NSString *)password;
- (void) requestCIOData;
- (void) syncUserInformation;

@end
