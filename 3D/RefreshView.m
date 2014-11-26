//
//  RefreshView.m
//  3D
//
//  Created by Chad Zeluff on 11/26/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "RefreshView.h"

@interface RefreshView()

@property (weak, nonatomic) IBOutlet UIView *progressView;

@end

@implementation RefreshView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    self.progressLayer = layer;
    
    UIBezierPath * circle = [UIBezierPath bezierPathWithOvalInRect:self.progressView.bounds];
    layer.path = circle.CGPath;
    layer.strokeColor =[[UIColor whiteColor]CGColor];
    layer.fillColor = [[UIColor clearColor]CGColor];
    [layer setLineWidth:1.0];
    [self.progressView.layer addSublayer:layer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
