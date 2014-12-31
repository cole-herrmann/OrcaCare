//
//  Rehab.h
//  OrcaCare
//
//  Created by Cole Herrmann on 12/30/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "Media.h"
#import <Foundation/Foundation.h>

@interface Rehab : NSObject

@property (nonatomic, copy) NSNumber *rehabId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSNumber *contentCategoryId;
@property (nonatomic, copy) NSString *kind;
@property (nonatomic, copy) NSString *subkind;
@property (nonatomic, copy) NSNumber *rehabCategoryId;
@property (nonatomic, copy) NSString *thumbUrl;
@property (nonatomic, copy) NSNumber *difficulty;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSDate *updatedAt;
@property (nonatomic, strong) NSArray *media;

@end
