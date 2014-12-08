//
//  OrcaObjectManager.m
//  Orca Care
//
//  Created by Chad Zeluff on 12/5/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "OrcaObjectManager.h"
#import "User.h"
#import <LUKeychainAccess/LUKeychainAccess.h>

@implementation OrcaObjectManager

- (id)initWithHTTPClient:(AFHTTPClient *)client {
    self = [super initWithHTTPClient:client];
    
    if(!self) return nil;
    
    [self setAuthHeadersToUser];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"userUpdated" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [self setAuthHeadersToUser];
    }];
    
    return self;
}

- (void)setAuthHeadersToUser {
    User *u = [[LUKeychainAccess standardKeychainAccess] objectForKey:@"user"];
    [self.HTTPClient setDefaultHeader:@"Authorization" value:u.authHeader];
}

@end
