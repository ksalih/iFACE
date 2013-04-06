//
//  IFACECoredataHelper.m
//  iFACE
//
//  Created by Jorge Carvallo on 4/6/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import "IFACECoredataHelper.h"
#import "AppDefinitions.h"
#import "ZKUserInfo.h" 
#import "AppDefinitions.h"

@implementation IFACECoredataHelper

+ (DPerson *) getDPersonByEmail:(NSString *) emailAddress withManagedObjectContext:(NSManagedObjectContext *) managedObjectContext{
    DPerson *dperson = nil;
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:USERS_TABLE inManagedObjectContext:managedObjectContext];
	[fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"email == %@", emailAddress];
    [fetchRequest setPredicate:predicate];

    NSArray *usersList = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (!usersList || [usersList count] ==0)
    {
       // error = [self generateErrorMessage:@"Invalid user name"];
        return nil;
    }
    
    dperson = [usersList objectAtIndex:0];
    return dperson;
}

+ (DPerson *) addOrUpdatePerson:(ZKUserInfo *) userInfo withManagedObjectContext:(NSManagedObjectContext *) managedObjectContext{
    DPerson *newPerson;
    NSError *error = nil;
    if (userInfo && userInfo.email){
        newPerson = [self getDPersonByEmail:userInfo.email withManagedObjectContext:managedObjectContext];
    }
    //can't find it, add it
    if (!newPerson){
        newPerson = [NSEntityDescription insertNewObjectForEntityForName:USERS_TABLE inManagedObjectContext:managedObjectContext];
    }
    
    newPerson.email = userInfo.email;
    newPerson.lastModifiedDate = [NSDate date];
    [managedObjectContext save:&error];
    return newPerson;
    
    /**
     <element name="accessibilityMode"          type="xsd:boolean"/>
     <element name="currencySymbol"             type="xsd:string" nillable="true"/>
     <element name="orgDefaultCurrencyIsoCode"  type="xsd:string" nillable="true"/>
     <element name="orgDisallowHtmlAttachments" type="xsd:boolean"/>
     <element name="orgHasPersonAccounts"       type="xsd:boolean"/>
     <element name="organizationId"             type="tns:ID"/>
     <element name="organizationMultiCurrency"  type="xsd:boolean"/>
     <element name="organizationName"           type="xsd:string"/>
     <element name="profileId"                  type="tns:ID"/>
     <element name="roleId"                     type="tns:ID" nillable="true"/>
     <element name="userDefaultCurrencyIsoCode" type="xsd:string" nillable="true"/>
     <element name="userEmail"                  type="xsd:string"/>
     <element name="userFullName"               type="xsd:string"/>
     <element name="userId"                     type="tns:ID"/>
     <element name="userLanguage"               type="xsd:string"/>
     <element name="userLocale"                 type="xsd:string"/>
     <element name="userName"                   type="xsd:string"/>
     <element name="userTimeZone"               type="xsd:string"/>
     <element name="userType"                   type="xsd:string"/>
     <element name="userUiSkin"                 type="xsd:string"/>
     */
    
}
@end
