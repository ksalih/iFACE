//
//  MobileBrokerClient.m
//  iFACE
//
//  Created by Jorge Carvallo on 4/6/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import "MobileBrokerClient.h"
#import "AppDefinitions.h"
#import "ApplicationPreferences.h"
#import "User.h"
#import "JYStringHelperFunctions.h"

@implementation MobileBrokerClient


#pragma mark - Static Methods
/**
 Singleton implementation
 This class will take care of synchronizing with the mobile broker.
 
 */
+ (MobileBrokerClient *)sharedClient{
    static MobileBrokerClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [MobileBrokerClient alloc];
    });
    return sharedClient;
}

/**
 * Authenticates the user with whatever remote machanism is choosen
 */
- (NSError *) login:(NSString *) userName password:(NSString *)password{
    NSError *error;
    error = nil;
    //searches for the user
    //use the current itinerary to get all companies
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:USERS_TABLE inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"username == %@", userName];
    [fetchRequest setPredicate:predicate];
    
    NSArray *usersList = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    //checks if the user exists
    if (!usersList || [usersList count] ==0)
    {
        error = [self generateErrorMessage:@"Invalid user name or password"];
        return error;
    }
    
    User *user = [usersList objectAtIndex:0];
    NSString *dbEncryptedPassword = user.password;
    //encrypts the supplied password with base64Encode encryption in order to compare
    NSString *encryptedPassword = [JYStringHelperFunctions base64Encode:password];
    
    if (![dbEncryptedPassword isEqualToString:encryptedPassword])
    {
        error = [self generateErrorMessage:@"Invalid user name or password"];
        return error;
    }
    
    //Saves the user name and password into the user preferences
    //password is always encrypted
    [ApplicationPreferences setApplicationUser:userName];
    [ApplicationPreferences setApplicationPassword:[JYStringHelperFunctions base64Encode:password]];
    //Makes sure the mobile broker is updated
    [MobileBrokerClient sharedClient].userName = userName;
    [MobileBrokerClient sharedClient].password = password;
    
    return error;
}

/*
 * Generates a generic error message object
 */
- (NSError *) generateErrorMessage:(NSString *) message {
    NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
    [errorDetail setValue:message forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:ERROR_DOMAIN_MAINAPP code:FOInvalidCredentials userInfo:errorDetail];
    return error;
}

- (NSString *) getSavedPasswordForUser:(NSString *) userName {
    NSError *error;
    error = nil;
    //searches for the user
    //use the current itinerary to get all companies
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:USERS_TABLE inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"username == %@", userName];
    [fetchRequest setPredicate:predicate];
    
    NSArray *usersList = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    //checks if the user exists
    if (!usersList || [usersList count] ==0)
    {
        error = [self generateErrorMessage:@"Invalid user name"];
        return nil;
    }
    
    User *user = [usersList objectAtIndex:0];
    return user.password;
}

- (void) requestCIOData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^(void) {
        ZKQueryResult *qr = [_client query:@"SELECT iface__Agency__c from iface__DCIO__c"];
        self.results = qr;
        
    });

}

@end
