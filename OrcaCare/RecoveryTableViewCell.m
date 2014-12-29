//
//  RecoveryTableViewCell.m
//  Orca Care
//
//  Created by Chad Zeluff on 12/12/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "RecoveryTableViewCell.h"

@implementation RecoveryTableViewCell

- (void)awakeFromNib {
    self.arrow.image = [self.arrow.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
