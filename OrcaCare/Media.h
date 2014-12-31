//
//  Media.h
//  Orca Care
//
//  Created by Chad Zeluff on 12/19/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Media : NSObject

@property (nonatomic, copy) NSNumber *mediaId;
@property (nonatomic, copy) NSNumber *contentCategoryId;
@property (nonatomic, copy) NSNumber *contentId;
@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, copy) NSString *fileContentType;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *fullUrl;
@property (nonatomic, copy) NSString *frameUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *parentId;
@property (nonatomic, copy) NSNumber *position;
@property (nonatomic, copy) NSNumber *sortOrder;
@property (nonatomic, copy) NSURL *thumbUrl;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSDate *updatedAt;

@end
