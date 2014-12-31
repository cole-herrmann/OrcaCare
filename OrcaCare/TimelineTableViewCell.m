//
//  TimelineTableViewCell.m
//  Orca Care
//
//  Created by Cole Herrmann on 12/17/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "TimelineTableViewCell.h"

@interface TimelineTableViewCell ()

@property (weak, nonatomic, readwrite) IBOutlet UIImageView *doctorPicture;
@property (weak, nonatomic, readwrite) IBOutlet UILabel *doctorLabel;
@property (weak, nonatomic, readwrite) IBOutlet UILabel *dateLabel;

@end

@implementation TimelineTableViewCell

- (void)awakeFromNib {
    // Initialization code
//    self.doctorPicture.layer.masksToBounds = YES;
    self.doctorPicture.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
