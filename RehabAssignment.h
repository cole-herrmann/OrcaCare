//
//  RehabAssignment.h
//  OrcaCare
//
//  Created by Cole Herrmann on 12/30/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rehab.h"

@interface RehabAssignment : NSObject

@property (nonatomic, copy) NSNumber *rehabAssignmentId;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSString *timeUnit;
@property (nonatomic, copy) NSNumber *duration;
@property (nonatomic, copy) NSNumber *frequency;
@property (nonatomic, copy) NSNumber *sets;
@property (nonatomic, copy) NSNumber *reps;
@property (nonatomic, copy) NSNumber *holdSeconds;
@property (nonatomic, copy) NSNumber *rehabId;
@property (nonatomic, copy) NSNumber *encounterId;
@property (nonatomic, copy) NSDate *updatedAt;
@property (nonatomic, strong) Rehab *rehab;

@end
