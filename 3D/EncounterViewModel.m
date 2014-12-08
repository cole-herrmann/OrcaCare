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

@implementation EncounterViewModel

- (void)all {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Encounter class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id": @"encounterId",
                                                  @"provider_id": @"providerId",
                                                  @"created_at": @"date",
                                                  @"diagnosis_ids": @"diagnosisIds",
                                                  @"treatment_ids": @"treatmentIds",
                                                  @"custom_media_ids": @"customMediaIds",
                                                  @"note_ids": @"noteIds",
                                                  @"handout_ids": @"handoutIds",
                                                  @"media_ids": @"mediaIds"
                                                  }];
    
    RKObjectManager *manager = [RKObjectManager sharedManager];
    [manager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:nil keyPath:@"encounters" statusCodes:nil]];
    
    [manager getObject:nil path:@"/v3/patient/encounters" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSArray *encounters = [mappingResult array];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"error");
    }];
}

@end
