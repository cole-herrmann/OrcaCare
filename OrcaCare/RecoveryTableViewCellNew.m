//
//  RecoveryTableViewCellNew.m
//  Orca Care
//
//  Created by Cole Herrmann on 12/23/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "RecoveryTableViewCellNew.h"

@interface RecoveryTableViewCellNew ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *firstDetail;
@property (weak, nonatomic) IBOutlet UILabel *secondDetail;
@property (weak, nonatomic) IBOutlet UILabel *thirdDetail;
@property (weak, nonatomic) IBOutlet UIView *glassView;

@end

@implementation RecoveryTableViewCellNew

- (void)awakeFromNib {
    self.glassView.layer.borderWidth = 1;
    self.glassView.layer.borderColor = [[UIColor colorWithRed:0.031 green:0.290 blue:0.522 alpha:1]CGColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
