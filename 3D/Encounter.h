//
//  Encounter.h
//  Orca Care
//
//  Created by Chad Zeluff on 12/5/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Provider;

@interface Encounter : NSObject

@property (nonatomic, copy) NSNumber *encounterId;
@property (nonatomic, copy) NSDate *createdDate;

//nested data
@property (nonatomic, copy) NSArray *diagnoses;
@property (nonatomic, copy) NSArray *treatments;
@property (nonatomic, copy) NSArray *customMedia;
@property (nonatomic, copy) NSArray *notes;
@property (nonatomic, copy) NSArray *handouts;
@property (nonatomic, copy) NSArray *media;
@property (nonatomic, strong) Provider *provider;


@end
