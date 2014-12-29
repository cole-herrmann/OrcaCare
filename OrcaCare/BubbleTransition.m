//
//  BubbleTransition.m
//  Orca Care
//
//  Created by Chad Zeluff on 12/23/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "BubbleTransition.h"

@implementation BubbleTransition

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController {
    self = [super init];
    if(!self) return nil;
    _navigationController = navigationController;
    
    [self commonSetup];
    
    return self;
}

- (void)commonSetup {
    self.navigationController.delegate = self;
    self.transitionDuration = 0.3;
    self.transitionAnimationOption = UIViewKeyframeAnimationOptionCalculationModeCubic;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.transitionDuration;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

@end
