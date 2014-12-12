//
//  PlanViewController.h
//  3D
//
//  Created by Cole Herrmann on 11/25/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlanViewController;

@protocol PlanVCDelegate <NSObject>

- (void)planVCShouldDismiss:(PlanViewController *)planVC;

@end

@interface PlanViewController : UIViewController

@property (nonatomic, weak) UIViewController<PlanVCDelegate> *delegate;

@end
