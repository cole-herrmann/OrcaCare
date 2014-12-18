//
//  PlanSectionTableViewCell.m
//  Orca Care
//
//  Created by Cole Herrmann on 12/17/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "PlanSectionTableViewCell.h"

@interface PlanSectionTableViewCell ()

@property (weak, nonatomic, readwrite) IBOutlet UILabel *planSectionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellCircle;

@end

@implementation PlanSectionTableViewCell

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
