//
//  Note.h
//  OrcaCare
//
//  Created by Cole Herrmann on 12/30/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property (nonatomic, copy) NSNumber *noteId;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSNumber *encounterId;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSDate *updatedAt;
@property (nonatomic, copy) NSString *title;

@end
