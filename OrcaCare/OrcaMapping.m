//
//  OrcaMapping.m
//  Orca Care
//
//  Created by Chad Zeluff on 12/17/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "OrcaMapping.h"
#import <RestKit/RestKit.h>
#import "User.h"
#import "Encounter.h"
#import "Provider.h"
#import "Diagnosis.h"
#import "CustomMedia.h"
#import "Media.h"

@implementation OrcaMapping

+ (RKObjectMapping *)userMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[User class]];
    
    NSDictionary *dictionary = @{
                                 @"id": @"userId",
                                 @"first_name": @"firstName",
                                 @"last_name": @"lastName",
                                 @"email": @"email",
                                 @"auth_header_value": @"authHeader"
                                 };
    
    [mapping addAttributeMappingsFromDictionary:dictionary];
    
    return mapping;
}

+ (RKObjectMapping *)encounterMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Encounter class]];
    
    NSDictionary *dictionary = @{
                                 @"id": @"encounterId",
                                 @"created_at": @"createdDate",
                                 };
    
    [mapping addAttributeMappingsFromDictionary:dictionary];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"provider" toKeyPath:@"provider" withMapping:[self providerMapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"diagnoses" toKeyPath:@"diagnoses" withMapping:[self diagnosisMapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"custom_media" toKeyPath:@"customMedia" withMapping:[self customMediaMapping]]];
    
    return mapping;
}

+ (RKObjectMapping *)providerMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Provider class]];
    
    NSDictionary *dictionary = @{
                                 @"id": @"providerId",
                                 @"created_at": @"createdDate",
                                 @"updated_at": @"updatedDate",
                                 @"first_name": @"firstName",
                                 @"last_name": @"lastName",
                                 @"email": @"email",
                                 @"prefix": @"prefix",
                                 @"suffix": @"suffix",
                                 @"photo_thumbnail_url": @"photoURL",
                                 @"logo_thumbnail_url": @"logoURL",
                                 @"occupation_id": @"occupationId",
                                 @"occupation_name": @"occupation"
                                 };
    
    [mapping addAttributeMappingsFromDictionary:dictionary];
    
    return mapping;
}

+ (RKObjectMapping *)diagnosisMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Diagnosis class]];
    
    NSDictionary *dictionary = @{
                                 @"id": @"diagnosisId",
                                 @"name": @"name",
                                 @"text": @"text",
                                 @"content_category_id": @"contentCategoryId",
                                 @"created_at": @"createdDate",
                                 @"updated_at": @"updatedDate",
                                 @"thumb_url": @"thumbURL"
                                 };
    
    [mapping addAttributeMappingsFromDictionary:dictionary];
//    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"media" toKeyPath:@"media" withMapping:[self mediaMapping]]];
    
    return mapping;
}

+ (RKObjectMapping *)customMediaMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[CustomMedia class]];
    
    NSDictionary *dictionary = @{
                                 @"id": @"customMediaId",
                                 @"label": @"label",
                                 @"asset_content_type": @"assetContentType",
                                 @"asset_file_name": @"assetFileName",
                                 @"url": @"URL",
                                 @"thumb_url": @"thumbURL",
                                 @"encounter_id": @"encounterId",
                                 @"created_at": @"createdDate",
                                 @"updated_at": @"updatedDate"
                                 };
    
    [mapping addAttributeMappingsFromDictionary:dictionary];
    
    return mapping;
}

+ (RKObjectMapping *)mediaMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Media class]];
    
    NSDictionary *dictionary = @{
                                 
                                 };
    
    [mapping addAttributeMappingsFromDictionary:dictionary];
    
    return mapping;
}

@end
