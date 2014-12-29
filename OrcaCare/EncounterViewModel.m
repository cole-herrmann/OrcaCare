//
//  EncounterViewModel.m
//  Orca Care
//
//  Created by Chad Zeluff on 12/5/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "EncounterViewModel.h"
#import <RestKit/RestKit.h>
#import "Encounter.h"
#import "OrcaMapping.h"

@implementation EncounterViewModel

- (void)all {
    RKObjectMapping *mapping = [OrcaMapping encounterMapping];
    RKObjectManager *manager = [RKObjectManager sharedManager];
    [manager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:nil keyPath:@"encounters" statusCodes:nil]];
    
    [manager getObject:nil path:@"/v3/patient/encounters" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSArray *encounters = [mappingResult array];
        NSString *response = operation.HTTPRequestOperation.responseString;
//        [self batchRequestsWithEncounters:encounters];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"error");
    }];
}

- (void)batchRequestsWithEncounters:(NSArray *)encounters {
//    RKObjectMapping *providerMapping = [RKObjectMapping mappingForClass:[Provider class]];
//    [providerMapping addAttributeMappingsFromDictionary:@{
//                                                  @"id": @"providerId",
//                                                  @"email": @"email"
//                                                  }];
//    
//    NSMutableArray *operations = [NSMutableArray array];
//    RKObjectManager *manager = [RKObjectManager sharedManager];
//    
//    for(Encounter *e in encounters) {
//        NSString *path = [NSString stringWithFormat:@"/v3/patient/encounters/%@/provider", e.encounterId];
//        NSMutableURLRequest *request = [manager requestWithObject:nil method:RKRequestMethodGET path:path parameters:nil];
//        RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:providerMapping method:RKRequestMethodGET pathPattern:nil keyPath:@"provider" statusCodes:nil];
//        RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
//        [operations addObject:operation];
//    }
//    [manager enqueueBatchOfObjectRequestOperations:operations progress:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
//        
//    } completion:^(NSArray *operations) {
//        
//    }];
}

@end
