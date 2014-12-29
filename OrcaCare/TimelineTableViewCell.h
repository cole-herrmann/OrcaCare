//
//  TimelineTableViewCell.h
//  Orca Care
//
//  Created by Cole Herrmann on 12/17/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimelineTableViewCell : UITableViewCell

@property (nonatomic, weak, readonly) UIImageView *doctorPicture;
@property (nonatomic, weak, readonly) UILabel *doctorLabel;
@property (nonatomic, weak, readonly) UILabel *dateLabel;

@end
