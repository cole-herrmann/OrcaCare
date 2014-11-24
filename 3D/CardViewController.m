//
//  ViewController.m
//  3D
//
//  Created by Cole Herrmann on 11/19/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "CardViewController.h"
#import <SceneKit/SceneKit.h>

@interface CardViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setupNavBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
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

@end
