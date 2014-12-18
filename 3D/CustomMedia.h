//
//  CustomMedia.h
//  Orca Care
//
//  Created by Chad Zeluff on 12/17/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomMedia : NSObject

@property (nonatomic, copy) NSNumber *customMediaId;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *assetContentType;
@property (nonatomic, copy) NSString *assetFileName;
@property (nonatomic, copy) NSURL *URL;
@property (nonatomic, copy) NSURL *thumbURL;
@property (nonatomic, copy) NSNumber *encounterId;
@property (nonatomic, copy) NSDate *createdDate;
@property (nonatomic, copy) NSDate *updatedDate;

@end
