//
//  OrcaObject.h
//  Orca Care
//
//  Created by Cole Herrmann on 12/19/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrcaObject : NSObject

@property (nonatomic, copy) NSDate *createdDate;
@property (nonatomic, copy) NSDate *updatedDate;
@property (nonatomic, copy) NSURL *thumbURL;
@property (nonatomic, copy) NSString *name;

@end
