//
//  WalkthroughShellViewController.h
//  OrcaWalkthrough
//
//  Created by Chad Zeluff on 10/2/14.
//  Copyright (c) 2014 orcahealth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardShellViewController : UIViewController

//@property (nonatomic, readonly) NSInteger totalSteps;

@property (nonatomic, strong) UIScrollView *scrollView;

- (void)addView:(UIView *)view;



//- (void)addViewController:(UIViewController *)vc;
//- (void)updatedParentScrollView:(UIScrollView *)parentScrollView;

@end
