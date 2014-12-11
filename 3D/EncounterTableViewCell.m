//
//  EncounterTableViewCell.m
//  3D
//
//  Created by Chad Zeluff on 11/26/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "EncounterTableViewCell.h"
#import <pop/POP.h>

@interface EncounterTableViewCell()

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (nonatomic, strong) NSArray *titleButtons;
@property (nonatomic, strong) CAShapeLayer *line;

@property (nonatomic) NSInteger yPos;

@end

@implementation EncounterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.yPos = self.titleLabel.center.y;

    [self.cardView.layer addSublayer:self.line];
}

- (CAShapeLayer *)line {
    if(_line == nil) {
        _line = [CAShapeLayer layer];
        _line.strokeColor =[[UIColor whiteColor]CGColor];
        _line.fillColor = [[UIColor clearColor]CGColor];
        [_line setLineWidth:1.0];
        _line.opacity = 0.0;
        _line.strokeStart = 0.5;
        _line.strokeEnd = 0.5;
    }
    
    return _line;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 50)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.cardView.bounds) - 10, 50)];
    self.line.path = path.CGPath;
}

- (void)openWithButtonTitles:(NSArray *)titles {
    NSMutableArray *buttons = [NSMutableArray array];
    
    for(int i = 0; i < titles.count; i++) {
        NSString *title = [titles objectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
//        [self.contentView addSubview:btn];
        [buttons addObject:btn];
        
        NSDictionary *viewsDictionary = @{@"btn" : btn, @"cV" : self.contentView};

//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:<#(NSString *)#> options:<#(NSLayoutFormatOptions)#> metrics:<#(NSDictionary *)#> views:<#(NSDictionary *)#>]]
        
        if(i == 0) {
            
        } else if (i == titles.count-1) {
            
        } else {
            
        }
    }
    
    [self open];
}

- (void)open {
    NSString *y = @"titlePosition";
    NSString *scale = @"titleScale";
    NSString *visible = @"visible";
    NSString *start = @"start";
    NSString *end = @"end";
    
    [self.titleLabel.layer pop_removeAllAnimations];
    [self.closeButton pop_removeAllAnimations];
    [self.line pop_removeAllAnimations];
    
    POPSpringAnimation *titlePosition = [self titlePositionAnimation];
    POPSpringAnimation *titleScale = [self titleScaleAnimation];
    POPBasicAnimation *buttonVisible = [self buttonVisibleAnimation];
    POPBasicAnimation *lineVisible = [self lineVisibleAnimation];
    POPBasicAnimation *lineStart = [self lineStartAnimation];
    POPBasicAnimation *lineEnd = [self lineEndAnimation];
    
    titlePosition.toValue = @30;
    titleScale.toValue = [NSValue valueWithCGSize:CGSizeMake(0.5, 0.5)];
    buttonVisible.toValue = @1;
    lineVisible.toValue = @1;
    lineStart.toValue = @0;
    lineEnd.toValue = @1;
    [titleScale setCompletionBlock:^(POPAnimation *animation, BOOL completed) {
        [self.closeButton pop_addAnimation:buttonVisible forKey:visible];
        [self.line pop_addAnimation:lineStart forKey:start];
        [self.line pop_addAnimation:lineEnd forKey:end];
    }];
    [self.titleLabel.layer pop_addAnimation:titlePosition forKey:y];
    [self.titleLabel.layer pop_addAnimation:titleScale forKey:scale];
    [self.line pop_addAnimation:lineVisible forKey:visible];
}

- (IBAction)close:(id)sender {
    NSString *y = @"titlePosition";
    NSString *scale = @"titleScale";
    NSString *visible = @"visible";
    NSString *start = @"start";
    NSString *end = @"end";
    
    [self.titleLabel.layer pop_removeAllAnimations];
    [self.closeButton pop_removeAllAnimations];
    [self.line pop_removeAllAnimations];
    
    POPSpringAnimation *titlePosition = [self titlePositionAnimation];
    POPSpringAnimation *titleScale = [self titleScaleAnimation];
    POPBasicAnimation *buttonVisible = [self buttonVisibleAnimation];
    POPBasicAnimation *lineVisible = [self lineVisibleAnimation];
    POPBasicAnimation *lineStart = [self lineStartAnimation];
    POPBasicAnimation *lineEnd = [self lineEndAnimation];
    
    titlePosition.toValue = @(self.yPos);
    titleScale.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0, 1.0)];
    buttonVisible.toValue = @0;
    lineVisible.toValue = @0;
    lineVisible.duration = 0.1;
    lineStart.toValue = @0.5;
    lineStart.duration = 0.1;
    lineEnd.duration = 0.1;
    lineEnd.toValue = @0.5;

    [self.line pop_addAnimation:lineVisible forKey:visible];
    [self.closeButton pop_addAnimation:buttonVisible forKey:visible];
    [self.titleLabel.layer pop_addAnimation:titlePosition forKey:y];
    [self.titleLabel.layer pop_addAnimation:titleScale forKey:scale];
    [self.line pop_addAnimation:lineStart forKey:start];
    [self.line pop_addAnimation:lineEnd forKey:end];
    if([self.delegate respondsToSelector:@selector(closeCell:)]) {
        [self.delegate closeCell:self];
    }
}

- (POPSpringAnimation *)titlePositionAnimation {
    POPSpringAnimation *titlePosition = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
//    titlePosition.velocity = @.2;
    titlePosition.springBounciness = 1;
    titlePosition.springSpeed = 5;
    return titlePosition;
}

- (POPSpringAnimation *)titleScaleAnimation {
    POPSpringAnimation *titleScale = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    titleScale.springSpeed = 30.0f;
    
    return titleScale;
}

- (POPBasicAnimation *)buttonVisibleAnimation {
    POPBasicAnimation *buttonAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    buttonAnimation.duration = 0.4;
    
    return buttonAnimation;
}

- (POPBasicAnimation *)lineVisibleAnimation {
    POPBasicAnimation *lineAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    lineAnimation.duration = 0.4;
    
    return lineAnimation;
}

- (POPBasicAnimation *)lineStartAnimation {
    POPBasicAnimation *lineStart = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeStart];
    lineStart.duration = 0.4;
    
    return lineStart;
}

- (POPBasicAnimation *)lineEndAnimation {
    POPBasicAnimation *lineEnd = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    lineEnd.duration = 0.4;
    
    return lineEnd;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
