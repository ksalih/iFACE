//
//  SFIFaceDelegate.m
//  iFACE
//
//  Created by Jorge Carvallo on 4/6/13.
//  Copyright (c) 2013 Deloitte. All rights reserved.
//

#import "SFIFaceDelegate.h"
#import "SFJsonUtils.h"
#import "SFAccountManager.h"
#import "SFOAuthCoordinator.h"
#import "SFOAuthCredentials.h"


/*
 NOTE if you ever need to update these, you can obtain them from your Salesforce org,
 (When you are logged in as an org administrator, go to Setup -> Develop -> Remote Access -> New )
 */


// Fill these in when creating a new Remote Access client on Force.com
static NSString *const RemoteAccessConsumerKey = @"3MVG9Iu66FKeHhINkB1l7xt7kR8czFcCTUhgoA8Ol2Ltf1eYHOU4SqQRSEitYFDUpqRWcoQ2.dBv_a1Dyu5xa";
static NSString *const OAuthRedirectURI = @"testsfdc:///mobilesdk/detect/oauth/done";


@implementation SFIFaceDelegate


#pragma mark - Remote Access / OAuth configuration

- (NSString*)remoteAccessConsumerKey {
    return RemoteAccessConsumerKey;
}

- (NSString*)oauthRedirectURI {
    return OAuthRedirectURI;
}


- (UIViewController*)newRootViewController {
    return self.rootController;
}

@end
