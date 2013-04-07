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

+ (void) copyZKSObject:(ZKSObject *)zkSObject toPerson:(DPerson *)person {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-ddTHH:mm:ssZ"];
    
    person.cellPhone = [zkSObject fieldValue:@"iface__Cellphone__c"];
    person.city = [zkSObject fieldValue:@"iface__City__c"];
    person.email = [zkSObject fieldValue:@"iface__Email__c"];
    person.facebookURL = [zkSObject fieldValue:@"iface__FacebookURL__c"];
    person.firstName = [zkSObject fieldValue:@"iface__FirstName__c"];
    
    person.lastModifiedDate = [dateFormat dateFromString:[zkSObject fieldValue:@"LastModifiedDate"]];

    person.lastName = [zkSObject fieldValue:@"iface__LastName__c"];
    person.linkedinURL = [zkSObject fieldValue:@"iface__LinkedInURL__c"];
    person.remoteID = [zkSObject fieldValue:@"iface__ID__c"];
    person.state = [zkSObject fieldValue:@"iface__State__c"];
    person.street = [zkSObject fieldValue:@"iface__Street__c"];
    person.title = [zkSObject fieldValue:@"iface__Title__c"];
    person.twitterURL = [zkSObject fieldValue:@"iface__Titile__c"];
    person.userName = [zkSObject fieldValue:@"iface__UserName__c"];
}

+ (void) copyZKSObject:(ZKSObject *)zkSObject toCIO:(DCIO *)cio {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-ddTHH:mm:ssZ"];
    
    cio.agency = [zkSObject fieldValue:@"iface__Agency__c"];
    cio.budgetAuthority = [zkSObject fieldValue:@"iface__BudgetAuthority__c"];
    cio.currentlyBeenMarked = [NSNumber numberWithInt:[(NSString *)[zkSObject fieldValue:@"iface__CurrentlyBeingMarketed__c"] integerValue]];
    
    cio.currentlyUnderContract = [zkSObject fieldValue:@"iface__CurrentlyUnderContract__c"];
    cio.topicsToAvoid = [zkSObject fieldValue:@"iface__TopicsToAvoid__c"];
    cio.sizeOfBudget = [zkSObject fieldValue:@"iface__SizeOfBudget__c"];
    cio.moneyToSpend = [zkSObject fieldValue:@"iface__MoneyToSpend__c"];
    cio.phone = [zkSObject fieldValue:@"iface__Phone__c"];
    cio.email = [zkSObject fieldValue:@"iface__Email__c"];
    cio.facebookURL = [zkSObject fieldValue:@"iface__FacebookURL__c"];
    cio.firstName = [zkSObject fieldValue:@"iface__FirstName__c"];
    
    cio.lastModifiedDate = [dateFormat dateFromString:[zkSObject fieldValue:@"LastModifiedDate"]];
    
    cio.lastName = [zkSObject fieldValue:@"iface__LastName__c"];
    cio.linkedinURL = [zkSObject fieldValue:@"iface__LinkedInURL__c"];
    cio.remoteID = [zkSObject fieldValue:@"iface__ID__c"];
    cio.title = [zkSObject fieldValue:@"iface__Title__c"];
    cio.twitterURL = [zkSObject fieldValue:@"iface__Titile__c"];
}

+ (NSString *) getUTCString:(NSDate *) date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:gmt];
    NSString *timeStamp = [dateFormatter stringFromDate:date];
    return timeStamp;
}

@end
