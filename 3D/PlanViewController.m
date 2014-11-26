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

@interface PlanViewController () <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@end

@implementation PlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    self.navigationController.delegate = self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC
{
//    TransitionAnimator *ta = [TransitionAnimator new];
//    if (operation == UINavigationControllerOperationPush) {
//        ta.isPushing = YES;
//        return ta;
//    } else if(operation == UINavigationControllerOperationPop) {
//        return ta;
//    }
    
    return [AMWaveTransition transitionWithOperation:operation andTransitionType:AMWaveTransitionTypeBounce];
    
    return nil;
}

@end
