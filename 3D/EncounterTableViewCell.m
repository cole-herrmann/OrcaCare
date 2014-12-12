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

@end

@implementation EncounterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
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
    
    self.cardView.layer.cornerRadius = 15.0f;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 50)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.cardView.bounds) - 10, 50)];
    self.line.path = path.CGPath;
}

- (void)openWithButtonTitles:(NSArray *)titles {
    NSMutableArray *buttons = [NSMutableArray array];
    
    for(int i = 0; i < titles.count; i++) {
        NSString *title = [titles objectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.alpha = 0;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [btn.titleLabel setTextAlignment:NSTextAlignmentLeft];
//        btn.backgroundColor = [UIColor redColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont fontWithName:@"ProximaNova-Light" size:20]];
        [btn addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.cardView addSubview:btn];
        [buttons addObject:btn];
        btn.tag = i;
        
//        NSDictionary *viewsDictionary = @{@"btn" : btn, @"cV" : self.contentView};

//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:<#(NSString *)#> options:<#(NSLayoutFormatOptions)#> metrics:<#(NSDictionary *)#> views:<#(NSDictionary *)#>]]
        
        if(i == 0) {
            btn.frame = CGRectMake(20, 60, CGRectGetWidth(self.cardView.bounds) - 10, 30);
        } else if (i == titles.count-1) {
            UIButton *prevBtn = [buttons objectAtIndex:i-1];
            CGRect prevFrame = prevBtn.frame;
            prevFrame.origin.y = CGRectGetMaxY(prevFrame) + 10;
            btn.frame = prevFrame;
        } else {
            UIButton *prevBtn = [buttons objectAtIndex:i-1];
            CGRect prevFrame = prevBtn.frame;
            prevFrame.origin.y = CGRectGetMaxY(prevFrame) + 10;
            btn.frame = prevFrame;
        }
    }
    
    self.titleButtons = [NSArray arrayWithArray:buttons];
    
    [self open];
}

- (void)titleButtonClicked:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(clickedRow:forCell:)]) {
        [self.delegate clickedRow:sender.tag forCell:self];
    }
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
    for(UIButton *btn in self.titleButtons) {
        [btn pop_removeAllAnimations];
    }
    
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
        for(UIButton *btn in self.titleButtons) {
            [btn pop_addAnimation:buttonVisible forKey:visible];
        }
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
    for(UIButton *btn in self.titleButtons) {
        [btn pop_removeAllAnimations];
    }
    
    POPSpringAnimation *titlePosition = [self titlePositionAnimation2];
    POPSpringAnimation *titleScale = [self titleScaleAnimation];
    POPBasicAnimation *buttonVisible = [self buttonVisibleAnimation];
    POPBasicAnimation *lineVisible = [self lineVisibleAnimation];
    POPBasicAnimation *lineStart = [self lineStartAnimation];
    POPBasicAnimation *lineEnd = [self lineEndAnimation];
    
    titlePosition.toValue = @0;
    titleScale.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0, 1.0)];
    buttonVisible.toValue = @0;
    lineVisible.toValue = @0;
    lineVisible.duration = 0.1;
    lineStart.toValue = @0.5;
    lineStart.duration = 0.1;
    lineEnd.duration = 0.1;
    lineEnd.toValue = @0.5;

    for(UIButton *btn in self.titleButtons) {
        [btn pop_addAnimation:buttonVisible forKey:visible];
    }
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

- (POPSpringAnimation *)titlePositionAnimation2 {
    POPSpringAnimation *titlePosition = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationY];
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
