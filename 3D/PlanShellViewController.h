//
//  PlanShellViewController.h
//  3D
//
//  Created by Chad Zeluff on 11/23/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlanShellViewController;

@protocol PlanShellDelegate <NSObject>

- (void)closePressed:(PlanShellViewController *)vc;

@end

@interface PlanShellViewController : UIViewController

@property (nonatomic, weak) UIViewController<PlanShellDelegate> *delegate;

- (void)addViewController:(UIViewController *)vc;

@end
