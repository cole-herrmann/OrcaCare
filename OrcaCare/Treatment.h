//
//  Treatment.h
//  OrcaCare
//
//  Created by Cole Herrmann on 12/30/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "OrcaObject.h"
#import <Foundation/Foundation.h>

@interface Treatment : OrcaObject

@property (nonatomic, copy) NSNumber *treatmentId;
@property (nonatomic, copy) NSNumber *contentCategoryId;
@property (nonatomic, copy) NSString *text;

@end
