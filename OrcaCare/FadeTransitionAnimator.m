//
//  FadeTransitionAnimator.m
//  OrcaCare
//
//  Created by Cole Herrmann on 12/27/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "FadeTransitionAnimator.h"

@implementation FadeTransitionAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.76;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    toViewController.view.alpha = 0;
    toViewController.view.frame = fromViewController.view.frame;
    
    [transitionContext.containerView addSubview:fromViewController.view];
    [transitionContext.containerView addSubview:toViewController.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        fromViewController.view.alpha = 0.0f;
        for (UIView *subview in fromViewController.view.subviews)
        {
            subview.alpha = 0.0f;
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            toViewController.view.alpha = 1.0f;
           
        }completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }];
}

@end
