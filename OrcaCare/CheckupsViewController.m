//
//  CheckupsViewController.m
//  Orca Care
//
//  Created by Chad Zeluff on 12/4/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "CheckupsViewController.h"
#import <pop/POP.h>

@interface CheckupsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *circleButtons;

@property (nonatomic) NSInteger currentIndex;

@end

@implementation CheckupsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _currentIndex = -1;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    for(UIButton *circleButton in self.circleButtons) {
        [circleButton setTitleColor:self.view.backgroundColor forState:UIControlStateNormal];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    
    if(_currentIndex != -1) {
        UIButton *btn = self.circleButtons[_currentIndex];
        btn.selected = NO;
    }
    
    _currentIndex = currentIndex;
    UIButton *btn = self.circleButtons[currentIndex];
    btn.selected = YES;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *)visibleCells {
    NSArray *startingElements = @[self.backView, self.questionLabel, self.positionLabel, self.nextButton];
    return [startingElements arrayByAddingObjectsFromArray:self.circleButtons];
}

- (IBAction)buttonDown:(id)sender {
    POPBasicAnimation *basicAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    basicAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(.95, .95)];
    
    [sender pop_addAnimation:basicAnimation forKey:@"shrinkDown"];
}

- (IBAction)buttonTapped:(UIButton *)sender {
    self.currentIndex = [sender.currentTitle integerValue] - 1;
    
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    springAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    springAnimation.springBounciness = 12;
    springAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(3, 3)];
    
    [sender pop_addAnimation:springAnimation forKey:@"bounceUp"];
}

@end
