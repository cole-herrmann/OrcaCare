//
//  TransitionAnimator.m
//  3D
//
//  Created by Cole Herrmann on 11/25/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "TransitionAnimator.h"

@implementation TransitionAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.4f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    // Grab the from and to view controllers from the context
    
    int dir = (self.isPushing) ? -1 : 1;
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [transitionContext.containerView addSubview:fromViewController.view];
    [transitionContext.containerView addSubview:toViewController.view];
    CGRect toVCEndFrame = toViewController.view.bounds;
    CGRect fromVCEndFrame = CGRectMake(dir * fromViewController.view.frame.size.width, 0, toViewController.view.frame.size.width, toViewController.view.frame.size.height);
    
    CGRect toVCStartFrame = toVCEndFrame;
    CGFloat width = toViewController.view.frame.size.width * ((self.isPushing) ? 1 : -1);
    toVCStartFrame.origin.x += width;
    toViewController.view.frame = toVCStartFrame;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.frame = fromVCEndFrame;
        toViewController.view.frame = toVCEndFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];


}


@end
