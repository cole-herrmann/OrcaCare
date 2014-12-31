//
//  BubbleTransition.m
//  Orca Care
//
//  Created by Chad Zeluff on 12/23/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "BubbleTransition.h"
#import <POP+MCAnimate.h>

@interface BubbleTransition()

@property (nonatomic) UINavigationControllerOperation operation;

@end

@interface UITableView (AMWaveTransition)
- (NSArray*)am_visibleViews;
@end

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
    self.transitionDuration = 1.0;
    self.transitionAnimationOption = UIViewKeyframeAnimationOptionCalculationModeCubic;
}

//We want to handle the pushes, thanks!
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    self.operation = operation;
    return self;
}

- (void)animateFromViewController:(UIViewController<BubbleTransitionProtocol> *)vc completion:(void (^)(void))completion {

}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController<BubbleTransitionProtocol> *fromVC = (id)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController<BubbleTransitionProtocol> *toVC = (id)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UITableView *fromTableView = [fromVC tableViewToBubble];
    UITableView *toTableView = [toVC tableViewToBubble];
    NSArray *downViews = [[[fromVC slideDownViews] reverseObjectEnumerator] allObjects];
    NSMutableArray *fromUpViews = [[fromVC slideUpViews] mutableCopy];
    
    UIView *selectedView = [fromUpViews lastObject];
//    selectedView.backgroundColor = [UIColor redColor];
    [containerView addSubview:selectedView];
    CGRect frame = [fromTableView rectForRowAtIndexPath:[fromTableView indexPathForSelectedRow]];
    selectedView.frame = [containerView convertRect:frame fromView:fromTableView];
    [fromUpViews removeLastObject];

    [toVC modifyViewForHeaderUse:selectedView];
    
    [fromUpViews pop_sequenceWithInterval:0 animations:^(UIView *upView, NSInteger index){
        CGRect frame = upView.frame;
        frame.origin.y -= containerView.bounds.size.height;
        upView.pop_spring.frame = frame;
        
    } completion:^(BOOL finished){
        [containerView insertSubview:toVC.view belowSubview:selectedView];
        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
        
        [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:nil completion:^(BOOL finished) {
            [[toTableView visibleCells] pop_sequenceWithInterval:0.05 animations:^(UIView *view, NSInteger index) {
                CGRect frame = view.frame;
                frame.origin.y += containerView.bounds.size.height;
                view.frame = frame;
                frame.origin.y -= containerView.bounds.size.height;
                view.pop_spring.frame = frame;
            } completion:^(BOOL finished) {
                [fromVC.view removeFromSuperview];
                UIView *snapshotView = [selectedView snapshotViewAfterScreenUpdates:NO];
                [toVC handleSnapshot:snapshotView];
                [selectedView removeFromSuperview];
                [transitionContext completeTransition:finished];
            }];
        }];
    }];
    
    [downViews pop_sequenceWithInterval:0 animations:^(UIView *downView, NSInteger index){
        CGRect frame = downView.frame;
        frame.origin.y += containerView.bounds.size.height;
        downView.pop_spring.frame = frame;
    } completion:^(BOOL finished){
    }];
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

@implementation UITableView (AMWaveTransition)

- (NSArray*)am_visibleViews {
    NSMutableArray *views = [NSMutableArray array];
    
    if (self.tableHeaderView.frame.size.height) {
        [views addObject:self.tableHeaderView];
    }
    
    NSInteger section = -1;
    for (NSIndexPath *indexPath in self.indexPathsForVisibleRows) {
        if (section != indexPath.section) {
            section = indexPath.section;
            UIView *view = [self headerViewForSection:section];
            if (view.frame.size.height) {
                [views addObject:view];
            }
            
            for (NSIndexPath *sectionIndexPath in self.indexPathsForVisibleRows) {
                if (sectionIndexPath.section != indexPath.section) {
                    continue;
                }
                
                view = [self cellForRowAtIndexPath:sectionIndexPath];
                if (view.frame.size.height) {
                    [views addObject:view];
                }
            }
            
            view = [self footerViewForSection:section];
            if (view.frame.size.height) {
                [views addObject:view];
            }
        }
    }
    
    if (self.tableFooterView.frame.size.height) {
        [views addObject:self.tableFooterView];
    }
    
    return views;
}

@end

