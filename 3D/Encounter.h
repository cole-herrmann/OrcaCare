//
//  Encounter.h
//  Orca Care
//
//  Created by Chad Zeluff on 12/5/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encounter : NSObject

@property (nonatomic, copy) NSNumber *encounterId;

@property (nonatomic, copy) NSArray *diagnosisIds;
@property (nonatomic, copy) NSArray *treatmentIds;
@property (nonatomic, copy) NSArray *customMediaIds;
@property (nonatomic, copy) NSArray *noteIds;
@property (nonatomic, copy) NSArray *handoutIds;
@property (nonatomic, copy) NSArray *mediaIds;

@property (nonatomic, copy) NSDate *date;
@property (nonatomic, copy) NSNumber *providerId;

@end
