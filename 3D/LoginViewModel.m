//
//  LoginViewModel.m
//  Orca Care
//
//  Created by Chad Zeluff on 12/5/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "LoginViewModel.h"
#import <RestKit/RestKit.h>
#import "User.h"
#import <LUKeychainAccess/LUKeychainAccess.h>

@implementation LoginViewModel

- (void)loginWithEmail:(NSString *)email password:(NSString *)password {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[User class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id": @"userId",
                                                  @"first_name": @"firstName",
                                                  @"last_name": @"lastName",
                                                  @"email": @"email",
                                                  @"auth_header_value": @"authHeader"
                                                  }];

    RKObjectManager *manager = [RKObjectManager sharedManager];
    [manager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodPOST pathPattern:nil keyPath:@"patient" statusCodes:nil]];
    
    NSDictionary *params = @{
                             @"patient" : @{
                                     @"email" : email,
                                     @"password" : password
                                     }
                             };
    
    [manager postObject:nil path:@"/v3/patient/login" parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        User *user = [mappingResult firstObject];
        [[LUKeychainAccess standardKeychainAccess] setObject:user forKey:@"user"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"userUpdated" object:nil userInfo:@{@"user" : user}];
        if([self.delegate respondsToSelector:@selector(loginSucceeded)]) {
            [self.delegate loginSucceeded];
        }

    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"error");
    }];
}

@end
