//
//  PlanViewController.m
//  3D
//
//  Created by Cole Herrmann on 11/25/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "PlanViewController.h"
#import "TransitionAnimator.h"
#import "AMWaveTransition.h"

@interface PlanViewController () <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *dismissView;
@property (weak, nonatomic) IBOutlet UIView *progressRing;
@property (strong, nonatomic) CAShapeLayer *shapeLayer;

@end

@implementation PlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBezierPath * circle = [UIBezierPath bezierPathWithOvalInRect:self.progressRing.bounds];
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.path = circle.CGPath;
    self.shapeLayer.strokeColor =[[UIColor whiteColor]CGColor];
    self.shapeLayer.fillColor = [[UIColor clearColor]CGColor];
    [self.shapeLayer setLineWidth:1.0];
    [self.progressRing.layer addSublayer:self.shapeLayer];
    
    CABasicAnimation *anim = [self pullDownAnimation];
    [self.shapeLayer addAnimation:anim
                                   forKey:@"fill circle as you drag"];
    self.shapeLayer.speed = 0.0f;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    self.navigationController.delegate = self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC
{
    return [AMWaveTransition transitionWithOperation:operation andTransitionType:AMWaveTransitionTypeBounce];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.shapeLayer.timeOffset = (-(scrollView.contentOffset.y / 120));
   
    if(scrollView.contentOffset.y == -120){
       
        [UIView animateWithDuration:0.4 animations:^{
            self.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            if([self.delegate respondsToSelector:@selector(planVCShouldDismiss:)]) {
                [self.delegate planVCShouldDismiss:self];
            }
        }];
    }
}

- (CABasicAnimation *)pullDownAnimation
{
    // Text is drawn by stroking the path from 0% to 100%
    CABasicAnimation *fillCircle = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    fillCircle.fromValue = @0;
    fillCircle.toValue = @1;
    fillCircle.duration = 1.0f;
    
    return fillCircle;
}

@end
