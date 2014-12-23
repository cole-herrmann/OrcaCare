//
//  MultipleChoiceTableViewCell.m
//  Orca Care
//
//  Created by Cole Herrmann on 12/22/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "MultipleChoiceTableViewCell.h"

@interface MultipleChoiceTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation MultipleChoiceTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
