//
//  BubbleTransition.h
//  Orca Care
//
//  Created by Chad Zeluff on 12/23/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BubbleTransitionProtocol <NSObject>

- (NSArray *)slideUpViews;
- (NSArray *)slideDownViews;

@end

@interface BubbleTransition : NSObject <UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

@property (nonatomic, readonly) UINavigationController *navigationController;

@property (nonatomic) CGFloat transitionDuration;
@property (nonatomic) UIViewKeyframeAnimationOptions transitionAnimationOption;

@end
