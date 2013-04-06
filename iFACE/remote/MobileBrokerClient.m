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
#import "ZKUserInfo.h" 
#import "DPerson.h"
#import "zkSObject.h"
#import "zkQueryResult.h"
#import "IFACECoredataHelper.h" 

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

//- (NSString *) getSavedPasswordForUser:(NSString *) userName {
//    NSError *error;
//    error = nil;
//    //searches for the user
//    //use the current itinerary to get all companies
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:USERS_TABLE inManagedObjectContext:self.managedObjectContext];
//    [fetchRequest setEntity:entity];
//    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"username == %@", userName];
//    [fetchRequest setPredicate:predicate];
//    
//    NSArray *usersList = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    
//    //checks if the user exists
//    if (!usersList || [usersList count] ==0)
//    {
//        error = [self generateErrorMessage:@"Invalid user name"];
//        return nil;
//    }
//    
//    DPerson *user = [usersList objectAtIndex:0];
//    return user.password;
//}

- (void) requestCIOData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^(void) {
        ZKQueryResult *qr = [_client query:@"SELECT iface__RelationshipLength__c from iface__PPDCIOAssoc__c"];
        self.results = qr;
        
    });

}

#pragma mark - variables assignment
- (void) setClient:(ZKSforceClient *) localClient {
    _client = localClient;
    
    ZKUserInfo *userInfo = _client.currentUserInfo;
    NSLog(@"email %@",userInfo.email);
    NSLog(@"fullName %@",userInfo.fullName);
    NSLog(@"userId %@",userInfo.userId);
    NSLog(@"userName %@",userInfo.userName);

    if ([self.delegate respondsToSelector:@selector(mobileBrokerClient:didFinishLoginWithClient:)]){
        [self.delegate mobileBrokerClient:self didFinishLoginWithClient:_client];
    }
}

#pragma mark - Synchronization methods
- (void) syncUserInformation {
    if (!self.client) return;
    
    ZKUserInfo *userInfo = self.client.currentUserInfo;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^(void) {
        NSString *queryString =
        [NSString stringWithFormat:@"SELECT iface__Cellphone__c,iface__Email__c from iface__DPerson__c where iface__Email__c = '%@'", userInfo.email];
        NSLog(@"Query string %@",queryString);
        
        ZKQueryResult *qr = [_client query:queryString];
        
        for (ZKSObject *zkSObject in qr.records){
            NSLog(@"value = %@",[zkSObject fieldValue:@"iface__Email__c"]);
        }
        
        ZKSObject *zkSObject;
        
        if ([qr.records count]>0){
            zkSObject = [qr.records objectAtIndex:0];
            DPerson *person = [IFACECoredataHelper addOrUpdatePerson:userInfo withManagedObjectContext:self.managedObjectContext];
            if (person){
                if ([self.delegate respondsToSelector:@selector(mobileBrokerClient:didFinishSynchronizingUser:)]){
                    [self.delegate mobileBrokerClient:self didFinishSynchronizingUser:person];
                }
            }else{
                if ([self.delegate respondsToSelector:@selector(mobileBrokerClient:didFailTransaction:)]){
                    [self.delegate mobileBrokerClient:self didFailTransaction:MobileBrokerClientErrorUserNotFound];
                }
            }
        }
        
    });
    
}


@end