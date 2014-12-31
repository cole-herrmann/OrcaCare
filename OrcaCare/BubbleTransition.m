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
    NSInteger count = fromUpViews.count;
    [containerView addSubview:toVC.view];
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    NSArray *toUpCells = toTableView.am_visibleViews;
    for(UIView *view in toUpCells) {
        [view setTransform:CGAffineTransformMakeTranslation(0, 300)];
    }
    
    __block NSArray *currentViews;
    __block NSUInteger currentVisibleViewsCount;
    
    void (^cellAnimation)(id, NSUInteger, BOOL*) = ^(UIView *view, NSUInteger idx, BOOL *stop){
//        BOOL fromMode = currentViews == fromViews;
        NSTimeInterval delay = 0;// ((float)idx / (float)currentVisibleViewsCount) * self.maxDelay;
//        if (!fromMode) {
            [view setTransform:CGAffineTransformMakeTranslation(0, 300)];
//        }
        void (^animation)() = ^{
//            if (fromMode) {
//                view.transform = CGAffineTransformMakeTranslation(0, -delta);
//                view.alpha = 0;
//            } else {
                view.transform = CGAffineTransformIdentity;
//                view.alpha = 1;
//            }
        };
        void (^completion)(BOOL) = ^(BOOL finished2){
//            if (fromMode) {
//                [view setTransform:CGAffineTransformIdentity];
//            }
        };
        [UIView animateWithDuration:2.5 delay:delay options:UIViewAnimationOptionCurveEaseIn animations:animation completion:completion];
        //            if (self.transitionType == AMWaveTransitionTypeSubtle) {
        //                [UIView animateWithDuration:self.duration delay:delay options:UIViewAnimationOptionCurveEaseIn animations:animation completion:completion];
        //            } else if (self.transitionType == AMWaveTransitionTypeNervous) {
        //                [UIView animateWithDuration:self.duration delay:delay usingSpringWithDamping:0.75 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:animation completion:completion];
        //            } else if (self.transitionType == AMWaveTransitionTypeBounce){
        //                [UIView animateWithDuration:self.duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:animation completion:completion];
        //            }
    };
    
    NSArray *viewsArrays = @[toUpCells];
    
    for (currentViews in viewsArrays) {
        // Animates all views
        currentVisibleViewsCount = currentViews.count;
        [currentViews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:cellAnimation];
    }
    
    
    UIView *selectedView = [fromUpViews lastObject];
//    UIView *copyView = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:selectedView]];
    selectedView.backgroundColor = [UIColor redColor];
//    selectedView.hidden = YES;
//    UIView *newView = [selectedView snapshotViewAfterScreenUpdates:NO];
    [containerView addSubview:selectedView];
//    newView.backgroundColor = [UIColor redColor];
    CGRect frame = [fromTableView rectForRowAtIndexPath:[fromTableView indexPathForSelectedRow]];
    selectedView.frame = [containerView convertRect:frame fromView:fromTableView];
//    [fromUpViews addObject:newView];
    
    [fromUpViews pop_sequenceWithInterval:0 animations:^(UIView *upView, NSInteger index){
        CGRect frame = upView.frame;
        if(index+1 == count) {
            frame = upView.bounds;
            [toVC modifyViewForHeaderUse:upView];
        } else {
            frame.origin.y -= containerView.bounds.size.height;
        }
        upView.pop_spring.frame = frame;
        
    } completion:^(BOOL finished){
        
        
        
        /* //this block moved the whole view into place
        [fromVC.view removeFromSuperview];
        //Move the entire view into place. Not doing individual cells because I was struggling to get them to load in properly.
        CGRect frame = toVC.view.frame;
        CGRect frameCopy = frame;
        frame.origin.y += containerView.bounds.size.height;
        toVC.view.frame = frame;
        [containerView addSubview:toVC.view];
        [NSObject pop_animate:^{
            toVC.view.pop_spring.frame = frameCopy;
        } completion:^(BOOL finished) {
            NSLog(@"transition done");
            [transitionContext completeTransition:finished];
        }];
         */
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

