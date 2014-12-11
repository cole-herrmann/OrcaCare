//
//  CardView.h
//  Orca Care
//
//  Created by Cole Herrmann on 12/8/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIButton

@property (weak, readonly, nonatomic) UIImageView *doctorImageView;
@property (weak, readonly, nonatomic) UILabel *doctorLabel;
@property (weak, readonly, nonatomic) UILabel *dateLabel;
@property (weak, readonly, nonatomic) UIView *shimmerView;

@end
