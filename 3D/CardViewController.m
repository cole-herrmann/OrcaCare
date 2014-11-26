//
//  ViewController.m
//  3D
//
//  Created by Cole Herrmann on 11/19/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "CardViewController.h"
#import <SceneKit/SceneKit.h>
#import <Shimmer/FBShimmeringView.h>
#import "PlanViewController.h"

@interface CardViewController () <PlanVCDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet FBShimmeringView *shimmerView;

@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:self.shimmerView.bounds];
    loadingLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:24];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = NSLocalizedString(@"New Care Plan", nil);
    self.shimmerView.contentView = loadingLabel;
    
    // Start shimmering.
    self.shimmerView.shimmering = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [self showScrollview];
}

- (void)showScrollview {
    [UIView animateWithDuration:0.4 animations:^{
        self.scrollView.alpha = 1.0f;
    }];
}

//- (void)setupNavBar {
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.view.backgroundColor = [UIColor clearColor];
//}

- (IBAction)cardClicked:(id)sender {
    
    [UIView animateWithDuration:0.4 animations:^{
        self.scrollView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self presentPlan];
    }];
}

- (void)presentPlan {
    UIStoryboard *stb = self.storyboard;
    UINavigationController *nav = [stb instantiateViewControllerWithIdentifier:@"planNav"];
//    NSArray *vcs = nav.viewControllers;
    PlanViewController *planVC = [nav.viewControllers firstObject];
    planVC.delegate = self;
    
    [self addChildViewController:nav];
    [self.view addSubview:nav.view];
    
    CGRect navFrame = nav.view.frame;
    navFrame.origin.y = CGRectGetMaxY(self.view.frame);
    nav.view.frame = navFrame;
    
    [UIView animateWithDuration:0.4 animations:^{
        nav.view.frame = self.view.bounds;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)planVCShouldDismiss:(PlanViewController *)planVC {
    
    [planVC.navigationController.view removeFromSuperview];
    [planVC.navigationController removeFromParentViewController];
    
    [self showScrollview];
    
}

@end
