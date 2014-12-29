//
//  CardView.m
//  Orca Care
//
//  Created by Cole Herrmann on 12/8/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "CardView.h"

@interface CardView ()

@property (weak, readwrite, nonatomic) IBOutlet UIImageView *doctorImageView;
@property (weak, readwrite, nonatomic) IBOutlet UILabel *doctorLabel;
@property (weak, readwrite, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, readwrite, nonatomic) IBOutlet FBShimmeringView *shimmerView;

@end

@implementation CardView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:self.bounds];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = @"New Care Plan";
    loadingLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:24];
    loadingLabel.textColor = [UIColor whiteColor];
    self.shimmerView.contentView = loadingLabel;
}

- (void)setNewPlan:(BOOL)newPlan {
    _newPlan = newPlan;
    
    self.shimmerView.hidden = !newPlan;
    self.shimmerView.shimmering = newPlan;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
