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
#import "zkSaveResult.h"
#import "DPerson.h"
#import "DCIO.h"
#import "DActivity.h"
#import "zkSObject.h"
#import "zkQueryResult.h"
#import "IFACECoredataHelper.h"
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

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            if ([self.delegate respondsToSelector:@selector(mobileBrokerClient:didFailTransaction:)]){
                [self.delegate mobileBrokerClient:self didFailTransaction:MobileBrokerClientErrorUserNotFound];
            }
            //abort();
        }
    }
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
        [NSString stringWithFormat:@"SELECT iface__Cellphone__c,iface__City__c,iface__Email__c, iface__FacebookURL__c,iface__FirstName__c, ID, LastModifiedDate,iface__LastName__c, iface__LinkedInURL__c,iface__State__c, iface__Street__c, iface__Title__c, iface__TwitterURL__c, iface__UserName__c from iface__DPerson__c where iface__Email__c = '%@'", userInfo.email];
        NSLog(@"Query string %@",queryString);
        
        ZKQueryResult *qr = [_client query:queryString];
        
        for (ZKSObject *zkSObject in qr.records){
            NSLog(@"value = %@",[zkSObject fieldValue:@"iface__Email__c"]);
        }
        
        ZKSObject *zkSObject;
        
        if ([qr.records count]>0){
            zkSObject = [qr.records objectAtIndex:0];
            DPerson *person = [IFACECoredataHelper addOrUpdatePerson:userInfo withManagedObjectContext:self.managedObjectContext];
            
            // copy the DPerson
            [IFACECoredataHelper copyZKSObject:zkSObject toPerson:person];
            
            // save the context
            [self saveContext];
            
            
            //copy data from zkSObject into person and do a managedObjectContext save
            
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

- (void) syncCIOInformation {
    if (!self.client) return;
    
    NSDate *lastSyncDate = [ApplicationPreferences lastSyncDate];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^(void) {
        NSString *utcDate = [IFACECoredataHelper getUTCString:lastSyncDate];
        
        NSLog(@"UTC date %@",utcDate);
        
        NSString *queryString =
        [NSString stringWithFormat:@"SELECT ID, iface__FirstName__c,iface__LastName__c, iface__Title__c, iface__Email__c, iface__Phone__c, iface__TwitterURL__c, iface__FacebookURL__c, iface__LinkedInURL__c, iface__TopicsToAvoid__c, iface__SizeOfBudget__c, iface__MoneyToSpend__c, iface__BudgetAuthority__c, iface__CurrentlyBeingMarketed__c, iface__CurrentlyUnderContract__c, iface__Agency__c, LastModifiedDate FROM iface__DCIO__c where LastModifiedDate > %@ order by ID ASC", utcDate];
        
        NSLog(@"Query string %@",queryString);
        
        ZKQueryResult *qr = [_client query:queryString];
        
        if ([qr.records count] > 0 ) {
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            // Edit the entity name as appropriate.
            NSEntityDescription *entity = [NSEntityDescription entityForName:CIO_TABLE inManagedObjectContext:self.managedObjectContext];
            [fetchRequest setEntity:entity];
            
            // Edit the sort key as appropriate.
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"remoteID" ascending:YES];
            NSArray *sortDescriptors = @[sortDescriptor];
            
            [fetchRequest setSortDescriptors:sortDescriptors];
            
            NSError *error = nil;
            NSArray *cioList = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
            

            [self mergeDataFrom:qr.records to:cioList];
        }
    });
    
}

- (void) syncActivityInformation {
    if (!self.client) return;
    
    // save the new activities
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^(void) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:ACTIVITY_TABLE inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        // Edit the predicate
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"remoteID == %@", nil];
        [fetchRequest setPredicate:predicate];
        
        
        NSError *error = nil;
        NSArray *activityList = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        for (DActivity *activity in activityList) {
            
            NSLog(@"Activity value = %@", activity);
            
            ZKSObject *activityObject = [ZKSObject withType:@"iforce__Activity__c"];
            
            [activityObject setFieldValue:activity.dcioInfo field:@"iface__DPerson__c"];
            [activityObject setFieldValue:activity.dCIO field:@"iface__DCIO__c"];
            [activityObject setFieldValue:activity.activityType field:@"iface__ActivityType__c"];
            [activityObject setFieldValue:activity.badgeAwarded field:@"iface__BadgeAwarded__c"];
            [activityObject setFieldValue:activity.badgeType field:@"iface__BadgeType__c"];
            [activityObject setFieldValue:activity.geoLat field:@"iface__GeoLat__c"];
            [activityObject setFieldValue:activity.geoLong field:@"iface__GeoLong__c"];
            [activityObject setFieldValue:activity.message field:@"iface__Message__c"];
            [activityObject setFieldValue:activity.venue field:@"iface__Venue__c"];
            
            NSArray *results = [self.client create:[NSArray arrayWithObject:activity]];
            
            ZKSaveResult *sr = [results objectAtIndex:0];
            if ([sr success]) {
                NSLog(@"New activity id %@", [sr id]);
                activity.remoteID = [sr id];
                [self saveContext];
            } else {
                NSLog(@"Error creating activity %@ %@", [sr statusCode], [sr message]);
            }
            
        }
    });
    
    // pull the non-existent activities
    NSDate *lastActivitiesSyncDate = [ApplicationPreferences lastActivitiesSyncDate];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^(void) {
        
        NSString *utcDate = [IFACECoredataHelper getUTCString:lastActivitiesSyncDate];
        
        NSLog(@"UTC date %@",utcDate);
        
        NSString *queryString =
        [NSString stringWithFormat:@"SELECT ID, iface__DPerson__c,iface__DCIO__c, iface__ActivityType__c, iface__BadgeAwarded__c, iface__BadgeType__c, iface__GeoLat__c, iface__GeoLong__c, iface__Message__c, iface__TopicsToAvoid__c, iface__SizeOfBudget__c, iface__MoneyToSpend__c, iface__BudgetAuthority__c, iface__Venue__c, LastModifiedDate FROM iface__DActivity__c where LastModifiedDate > %@ order by ID ASC", utcDate];
        
        NSLog(@"Query string %@",queryString);
        
        ZKQueryResult *qr = [_client query:queryString];
        
        if ([qr.records count] > 0 ) {
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            // Edit the entity name as appropriate.
            NSEntityDescription *entity = [NSEntityDescription entityForName:ACTIVITY_TABLE inManagedObjectContext:self.managedObjectContext];
            [fetchRequest setEntity:entity];
            
            // Edit the sort key as appropriate.
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"remoteID" ascending:YES];
            NSArray *sortDescriptors = @[sortDescriptor];
            
            [fetchRequest setSortDescriptors:sortDescriptors];
            
            NSError *error = nil;
            NSArray *activitiesList = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
            
            [self mergeDataFrom:qr.records to:activitiesList];
        }
    });
    
}

- (void) syncPPDCIOAssocInformation {
    if (!self.client) return;
    
    // save the new activities
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^(void) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:PPDCIOASSOC_TABLE inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        // Edit the predicate
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"remoteID == %@", nil];
        [fetchRequest setPredicate:predicate];
        
        
        NSError *error = nil;
        NSArray *ppdCIOAssocList = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        for (PPDCIOAssoc *ppdCIOAssoc in ppdCIOAssocList) {
            
            NSLog(@"Activity value = %@", ppdCIOAssoc);
            
            ZKSObject *ppdCIOAssocObject = [ZKSObject withType:@"iface__PPDCIOAssoc__c"];
            
            [ppdCIOAssocObject setFieldValue:ppdCIOAssoc.dcioInfo field:@"iface__DPerson__c"];
            [ppdCIOAssocObject setFieldValue:ppdCIOAssoc.dCIO field:@"iface__DCIO__c"];
            [ppdCIOAssocObject setFieldValue:ppdCIOAssoc.relationshipLength field:@"iface__RelationshipLength__c"];
            [ppdCIOAssocObject setFieldValue:ppdCIOAssoc.relationshipType field:@"iface__RelationshipType__c"];
            [ppdCIOAssocObject setFieldValue:ppdCIOAssoc.strength field:@"iface__Strength__c"];
            
            NSArray *results = [self.client create:[NSArray arrayWithObject:ppdCIOAssoc]];
            
            ZKSaveResult *sr = [results objectAtIndex:0];
            if ([sr success]) {
                NSLog(@"New activity id %@", [sr id]);
                ppdCIOAssoc.remoteID = [sr id];
                [self saveContext];
            } else {
                NSLog(@"Error creating activity %@ %@", [sr statusCode], [sr message]);
            }
            
        }
    });
    
    // pull the non-existent activities
    NSDate *lastPPDCIOAssocSyncDate = [ApplicationPreferences lastPPDCIOAssocSyncDate];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^(void) {
        
        NSString *utcDate = [IFACECoredataHelper getUTCString:lastPPDCIOAssocSyncDate];
        
        NSLog(@"UTC date %@",utcDate);
        
        NSString *queryString =
        [NSString stringWithFormat:@"SELECT ID, iface__DPerson__c,iface__DCIO__c, iface__RelationshipLength__c, iface__RelationshipType__c, iface__BadgeType__c, iface__GeoLat__c, iface__GeoLong__c, iface__Message__c, iface__TopicsToAvoid__c, iface__SizeOfBudget__c, iface__Strength__c, LastModifiedDate FROM iface__DPPDCIOAssoc__c where LastModifiedDate > %@ order by ID ASC", utcDate];
        
        NSLog(@"Query string %@",queryString);
        
        ZKQueryResult *qr = [_client query:queryString];
        
        if ([qr.records count] > 0 ) {
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            // Edit the entity name as appropriate.
            NSEntityDescription *entity = [NSEntityDescription entityForName:PPDCIOASSOC_TABLE inManagedObjectContext:self.managedObjectContext];
            [fetchRequest setEntity:entity];
            
            // Edit the sort key as appropriate.
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"remoteID" ascending:YES];
            NSArray *sortDescriptors = @[sortDescriptor];
            
            [fetchRequest setSortDescriptors:sortDescriptors];
            
            NSError *error = nil;
            NSArray *activitiesList = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
            
            [self mergePPDCIOAssocDataFrom:qr.records to:activitiesList];
        }
    });
    
}

- (void) syncPPDAssocInformation {
    if (!self.client) return;
    
    // save the new activities
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^(void) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:PPDASSOC_TABLE inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        // Edit the predicate
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"remoteID == %@", nil];
        [fetchRequest setPredicate:predicate];
        
        
        NSError *error = nil;
        NSArray *ppdAssocList = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        for (PPDAssoc *ppdAssoc in ppdAssocList) {
            
            NSLog(@"Activity value = %@", ppdAssoc);
            
            ZKSObject *ppdAssocObject = [ZKSObject withType:@"iface__PPDAssoc__c"];
            
            [ppdAssocObject setFieldValue:ppdAssoc.dPerson field:@"iface__DPerson__c"];
            [ppdAssocObject setFieldValue:ppdAssoc.dPersonRelated field:@"iface__DPersonRelated__c"];
            
            NSArray *results = [self.client create:[NSArray arrayWithObject:ppdAssoc]];
            
            ZKSaveResult *sr = [results objectAtIndex:0];
            if ([sr success]) {
                NSLog(@"New activity id %@", [sr id]);
                ppdAssoc.remoteID = [sr id];
                [self saveContext];
            } else {
                NSLog(@"Error creating activity %@ %@", [sr statusCode], [sr message]);
            }
            
        }
    });
    
    // pull the non-existent activities
    NSDate *lastPPDAssocSyncDate = [ApplicationPreferences lastPPDAssocSyncDate];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^(void) {
        
        NSString *utcDate = [IFACECoredataHelper getUTCString:lastPPDAssocSyncDate];
        
        NSLog(@"UTC date %@",utcDate);
        
        NSString *queryString =
        [NSString stringWithFormat:@"SELECT ID, iface__DPerson__c,iface__DPersonRelated__c, LastModifiedDate FROM iface__DPPDAssoc__c where LastModifiedDate > %@ order by ID ASC", utcDate];
        
        NSLog(@"Query string %@",queryString);
        
        ZKQueryResult *qr = [_client query:queryString];
        
        if ([qr.records count] > 0 ) {
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            // Edit the entity name as appropriate.
            NSEntityDescription *entity = [NSEntityDescription entityForName:PPDASSOC_TABLE inManagedObjectContext:self.managedObjectContext];
            [fetchRequest setEntity:entity];
            
            // Edit the sort key as appropriate.
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"remoteID" ascending:YES];
            NSArray *sortDescriptors = @[sortDescriptor];
            
            [fetchRequest setSortDescriptors:sortDescriptors];
            
            NSError *error = nil;
            NSArray *activitiesList = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
            
            [self mergePPDAssocDataFrom:qr.records to:activitiesList];
        }
    });
    
}



/**
 Merges data following find-and-update from apple
 */
-(void) mergeDataFrom:(NSArray *) zkSObjectsArray to:(NSArray *) cioManagedObjects {
    NSEnumerator *zkSObjectsEnumerator = [zkSObjectsArray objectEnumerator];
    NSEnumerator *cioManagedObjectsEnumerator = [cioManagedObjects objectEnumerator];
    
    id object;
    DCIO *currentCIO = [cioManagedObjectsEnumerator nextObject];
    DCIO *cioToUpdate;
    
    while (object = [zkSObjectsEnumerator nextObject]) {
        NSString *remoteID = [object fieldValue:@"ID"];
        NSLog(@"Compary %@",remoteID);
        if ([remoteID isEqualToString:currentCIO.remoteID]){
            cioToUpdate = currentCIO;
            currentCIO = [cioManagedObjectsEnumerator nextObject];
        }else{
            cioToUpdate = [NSEntityDescription insertNewObjectForEntityForName:CIO_TABLE inManagedObjectContext:self.managedObjectContext];
        }
        
        [IFACECoredataHelper copyZKSObject:object toCIO:cioToUpdate];
        
    }
    
    [self saveContext];
    
}

/**
 Merges data following find-and-update from apple
 */
-(void) mergeActivityFrom:(NSArray *) zkSObjectsArray to:(NSArray *) activityManagedObjects {
    NSEnumerator *zkSObjectsEnumerator = [zkSObjectsArray objectEnumerator];
    NSEnumerator *activityManagedObjectsEnumerator = [activityManagedObjects objectEnumerator];
    
    id object;
    DActivity *currentActivity = [activityManagedObjectsEnumerator nextObject];
    DActivity *activityToUpdate;
    
    while (object = [zkSObjectsEnumerator nextObject]) {
        NSString *remoteID = [object fieldValue:@"ID"];
        NSLog(@"Compary %@",remoteID);
        
        if ([remoteID isEqualToString:currentActivity.remoteID]){
            activityToUpdate = currentActivity;
            currentActivity = [activityManagedObjectsEnumerator nextObject];
        }else{
            activityToUpdate = [NSEntityDescription insertNewObjectForEntityForName:ACTIVITY_TABLE inManagedObjectContext:self.managedObjectContext];
        }
        
        [IFACECoredataHelper copyZKSObject:object toActivity:activityToUpdate];
        
    }
    
    [self saveContext];
    
}

/**
 Merges data following find-and-update from apple
 */
-(void) mergePPDCIOAssocDataFrom:(NSArray *) zkSObjectsArray to:(NSArray *) ppdCIOAssocManagedObjects {
    NSEnumerator *zkSObjectsEnumerator = [zkSObjectsArray objectEnumerator];
    NSEnumerator *ppdCIOAssocManagedObjectsEnumerator = [ppdCIOAssocManagedObjects objectEnumerator];
    
    id object;
    PPDCIOAssoc *currentPPDCIOAssoc = [ppdCIOAssocManagedObjectsEnumerator nextObject];
    PPDCIOAssoc *ppdCIOAssocToUpdate;
    
    while (object = [zkSObjectsEnumerator nextObject]) {
        NSString *remoteID = [object fieldValue:@"ID"];
        NSLog(@"Compary %@",remoteID);
        
        if ([remoteID isEqualToString:currentPPDCIOAssoc.remoteID]){
            ppdCIOAssocToUpdate = currentPPDCIOAssoc;
            currentPPDCIOAssoc = [ppdCIOAssocManagedObjectsEnumerator nextObject];
        }else{
            ppdCIOAssocToUpdate = [NSEntityDescription insertNewObjectForEntityForName:PPDCIOASSOC_TABLE inManagedObjectContext:self.managedObjectContext];
        }
        
        [IFACECoredataHelper copyZKSObject:object toPPDCIOAssoc:ppdCIOAssocToUpdate];
        
    }
    
    [self saveContext];
    
}

/**
 Merges data following find-and-update from apple
 */
-(void) mergePPDAssocDataFrom:(NSArray *) zkSObjectsArray to:(NSArray *) ppdAssocManagedObjects {
    NSEnumerator *zkSObjectsEnumerator = [zkSObjectsArray objectEnumerator];
    NSEnumerator *ppdAssocManagedObjectsEnumerator = [ppdAssocManagedObjects objectEnumerator];
    
    id object;
    PPDAssoc *currentPPDAssoc = [ppdAssocManagedObjectsEnumerator nextObject];
    PPDAssoc *ppdAssocToUpdate;
    
    while (object = [zkSObjectsEnumerator nextObject]) {
        NSString *remoteID = [object fieldValue:@"ID"];
        NSLog(@"Compary %@",remoteID);
        
        if ([remoteID isEqualToString:currentPPDAssoc.remoteID]){
            ppdAssocToUpdate = currentPPDAssoc;
            currentPPDAssoc = [ppdAssocManagedObjectsEnumerator nextObject];
        }else{
            ppdAssocToUpdate = [NSEntityDescription insertNewObjectForEntityForName:PPDASSOC_TABLE inManagedObjectContext:self.managedObjectContext];
        }
        
        [IFACECoredataHelper copyZKSObject:object toPPDAssoc:ppdAssocToUpdate];
        
    }
    
    [self saveContext];
    
}


@end
                   
