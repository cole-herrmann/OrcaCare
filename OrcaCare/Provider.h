//
//  Provider.h
//  Orca Care
//
//  Created by Chad Zeluff on 12/15/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Provider : NSObject

@property (nonatomic, copy) NSNumber *providerId;
@property (nonatomic, copy) NSDate *createdDate;
@property (nonatomic, copy) NSDate *updatedDate;
@property (nonatomic, copy) NSNumber *occupationId;

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *prefix;
@property (nonatomic, copy) NSString *suffix;
@property (nonatomic, copy) NSString *occupation;

@property (nonatomic, copy) NSString *photoURL;
@property (nonatomic, copy) NSString *logoURL;

@end
