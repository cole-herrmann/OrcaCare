//
//  LoginViewModel.m
//  Orca Care
//
//  Created by Chad Zeluff on 12/5/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "LoginViewModel.h"
#import <RestKit/RestKit.h>
#import <LUKeychainAccess/LUKeychainAccess.h>
#import "User.h"
#import "OrcaMapping.h"

@implementation LoginViewModel

- (void)loginWithEmail:(NSString *)email password:(NSString *)password {
    
    RKObjectMapping *mapping = [OrcaMapping userMapping];
    RKObjectManager *manager = [RKObjectManager sharedManager];
    [manager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodPOST pathPattern:nil keyPath:@"patient" statusCodes:nil]];
    
    NSDictionary *params = @{
                             @"patient" : @{
                                     @"email" : @"zeluff@orcahealth.com",
                                     @"password" : @"password"
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
        NSString *response = operation.HTTPRequestOperation.responseString;
        NSLog(@"error");
    }];
}

@end
