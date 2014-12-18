//
//  Diagnosis.h
//  Orca Care
//
//  Created by Chad Zeluff on 12/17/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Diagnosis : NSObject

@property (nonatomic, copy) NSNumber *diagnosisId;
@property (nonatomic, copy) NSNumber *contentCategoryId;
@property (nonatomic, copy) NSDate *createdDate;
@property (nonatomic, copy) NSDate *updatedDate;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSURL *thumbURL;


@end
