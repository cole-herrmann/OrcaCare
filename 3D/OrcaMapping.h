//
//  OrcaMapping.h
//  Orca Care
//
//  Created by Chad Zeluff on 12/17/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface OrcaMapping : NSObject

+ (RKObjectMapping *)userMapping;
+ (RKObjectMapping *)encounterMapping;
+ (RKObjectMapping *)providerMapping;
+ (RKObjectMapping *)diagnosisMapping;
+ (RKObjectMapping *)customMediaMapping;


@end
