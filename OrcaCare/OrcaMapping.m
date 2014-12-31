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
#import "Treatment.h"
#import "RehabAssignment.h"
#import "Rehab.h"
#import "Note.h"

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
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"treatments" toKeyPath:@"treatments" withMapping:[self treatmentMapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"rehab_assignments" toKeyPath:@"rehabAssignments" withMapping:[self rehabAssignmentMapping]]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"notes" toKeyPath:@"notes" withMapping:[self noteMapping]]];

    
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
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"media" toKeyPath:@"media" withMapping:[self mediaMapping]]];
    
    return mapping;
}

+ (RKObjectMapping *)treatmentMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Treatment class]];
    
    NSDictionary *dictionary = @{
                                 @"id": @"treatmentId",
                                 @"name": @"name",
                                 @"text": @"text",
                                 @"content_category_id": @"contentCategoryId",
                                 @"created_at": @"createdDate",
                                 @"updated_at": @"updatedDate",
                                 @"thumb_url": @"thumbURL"
                                 };
    
    [mapping addAttributeMappingsFromDictionary:dictionary];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"media" toKeyPath:@"media" withMapping:[self mediaMapping]]];
    
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
                                 @"id" : @"mediaId",
                                 @"content_category_id" : @"contentCategoryId",
                                 @"content_id" : @"contentId",
                                 @"content_type" : @"contentType",
                                 @"file_content_type" : @"fileContentType",
                                 @"file_name" : @"fileName",
                                 @"full_url" : @"fullUrl",
                                 @"frame_url" : @"frameUrl",
                                 @"name" : @"name",
                                 @"parent_id" : @"parentId",
                                 @"position" : @"position",
                                 @"sort_order" : @"sortOrder",
                                 @"thumb_url" : @"thumbUrl",
                                 @"created_at" : @"createdAt",
                                 @"updated_at" : @"updatedAt"
                                 };
    
    [mapping addAttributeMappingsFromDictionary:dictionary];
    
    return mapping;
}

+ (RKObjectMapping *)rehabAssignmentMapping {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[RehabAssignment class]];
    
    NSDictionary *dictionary = @{
                                 @"id" : @"rehabAssignmentId",
                                 @"created_at" : @"createdAt",
                                 @"time_unit" : @"timeUnit",
                                 @"duration" : @"duration",
                                 @"frequency" : @"frequency",
                                 @"sets" : @"sets",
                                 @"reps" : @"reps",
                                 @"hold_seconds" : @"holdSeconds",
                                 @"rehab_id" : @"rehabId",
                                 @"encounter_id" : @"encounterId",
                                 @"updated_at" : @"updatedAt"
                                 };
    
    [mapping addAttributeMappingsFromDictionary:dictionary];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"rehab" toKeyPath:@"rehab" withMapping:[self rehabMapping]]];

    
    return mapping;
}

+ (RKObjectMapping *)rehabMapping {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Rehab class]];
    
    
    NSDictionary *dictionary = @{
                                 @"id" : @"rehabId",
                                 @"name" : @"name",
                                 @"text" : @"text",
                                 @"content_category_id" : @"contentCategoryId",
                                 @"kind" : @"kind",
                                 @"subkind" : @"subkind",
                                 @"rehab_category_id" : @"rehabCategoryId",
                                 @"thumb_url" : @"thumbUrl",
                                 @"difficulty" : @"difficulty",
                                 @"created_at" : @"createdAt",
                                 @"updated_at" : @"updatedAt"
                                 };
    
    [mapping addAttributeMappingsFromDictionary:dictionary];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"media" toKeyPath:@"media" withMapping:[self mediaMapping]]];

    
    return mapping;
}

+ (RKObjectMapping *)noteMapping {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Note class]];
        
    NSDictionary *dictionary = @{
                                 @"id" : @"noteId",
                                 @"body" : @"body",
                                 @"encounter_id" : @"encounterId",
                                 @"created_at" : @"createdAt",
                                 @"updated_at" : @"updatedAt",
                                 @"title" : @"title"
                                 };
    
    [mapping addAttributeMappingsFromDictionary:dictionary];
    
    return mapping;
}



@end
