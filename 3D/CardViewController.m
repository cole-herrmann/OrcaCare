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
#import "Orca_Care-Swift.h"
#import "LoginViewModel.h"
#import "EncounterViewModel.h"

@interface CardViewController () <LoginVMDelegate, PlanVCDelegate, UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) LoginViewModel *loginVM;
@property (nonatomic, strong) EncounterViewModel *encounterVM;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet FBShimmeringView *shimmerView;
@property (weak, nonatomic) IBOutlet UIView *touchableView;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (nonatomic, weak) UIButton *clickedButton;

@end

@implementation CardViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(!self) return nil;
    
    self.loginVM = [[LoginViewModel alloc] init];
    self.loginVM.delegate = self;
    
    self.encounterVM = [[EncounterViewModel alloc] init];
    
    return self;
}

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
    self.scrollView.contentSize = CGSizeMake(227*3 + 8*3, 1);
    [self.touchableView addGestureRecognizer:self.scrollView.panGestureRecognizer];
    
    [self.loginVM loginWithEmail:@"zeluff@orcahealth.com" password:@"password"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)hideScrollView:(BOOL)hide completion:(void (^)())completion {
    CGFloat scrollAlpha = hide ? 0.0f : 1.0f;
    CGFloat buttonAlpha = hide ? 0.0f : 0.75f;
    [UIView animateWithDuration:0.4 animations:^{
        self.scrollView.alpha = scrollAlpha;
        self.searchButton.alpha = buttonAlpha;
        self.settingsButton.alpha = buttonAlpha;
    } completion:^(BOOL finished) {
        if(completion) {
            completion();
        }
    }];
}

//- (void)setupNavBar {
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.view.backgroundColor = [UIColor clearColor];
//}

- (IBAction)searchClicked:(id)sender {
    UIStoryboard *stb = self.storyboard;
    UINavigationController *nav = [stb instantiateViewControllerWithIdentifier:@"searchNav"];
    nav.transitioningDelegate = self;
    nav.modalPresentationStyle = UIModalPresentationCustom;
    self.clickedButton = sender;
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)settingsClicked:(id)sender {
    UIStoryboard *stb = self.storyboard;
    UINavigationController *nav = [stb instantiateViewControllerWithIdentifier:@"settingsNav"];
    nav.transitioningDelegate = self;
    nav.modalPresentationStyle = UIModalPresentationCustom;
    self.clickedButton = sender;
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)cardClicked:(id)sender {
    [self hideScrollView:YES completion:^{
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
    
    [self hideScrollView:NO completion:nil];
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    CircleTransitionAnimator *animator = [[CircleTransitionAnimator alloc] init];
    animator.animationButton = self.clickedButton;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    CircleTransitionAnimator *animator = [[CircleTransitionAnimator alloc] init];
    animator.animationButton = self.clickedButton;
    animator.presenting = NO;
    return animator;
    
    return nil;
}

- (void)loginSucceeded {
    [self.encounterVM all];
}

@end
