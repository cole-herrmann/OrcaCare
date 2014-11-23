//
//  PlanShellViewController.m
//  3D
//
//  Created by Chad Zeluff on 11/23/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "PlanShellViewController.h"

@interface PlanShellViewController ()

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *lastConstraints;

@end

@implementation PlanShellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self.view insertSubview:scrollView atIndex:0];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *viewsDictionary = @{@"sv":scrollView};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[sv]-0-|" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[sv]-0-|" options:0 metrics:nil views:viewsDictionary]];
}

- (void)addViewController:(UIViewController *)vc {
    [self addChildViewController:vc];
    NSDictionary *viewsDictionary = @{@"vcView" : vc.view, @"selfView" : self.view};
    vc.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:vc.view];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[vcView(==selfView)]" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[vcView(==selfView)]" options:0 metrics:nil views:viewsDictionary]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[vcView]|" options:0 metrics:nil views:viewsDictionary]];
    
    if([self.childViewControllers count] == 1) {
        [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[vcView]" options:0 metrics:nil views:viewsDictionary]];
    } else {
        UIViewController *previousVC = self.childViewControllers[self.childViewControllers.count - 2];
        UIView *previousView = previousVC.view;
        [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[pv]-0-[v]" options:0 metrics:nil views:@{@"pv" : previousView, @"v" : vc.view}]];
        
        if(self.lastConstraints) {
            [self.scrollView removeConstraints:self.lastConstraints];
        }
        
        self.lastConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[v]-0-|" options:0 metrics:nil views:@{@"v" : vc.view}];
        [self.scrollView addConstraints:self.lastConstraints];
    }
}

- (IBAction)cancelClicked:(id)sender {
    
    if([self.delegate respondsToSelector:@selector(closePressed:)]) {
        [self.delegate closePressed:self];
    }
}

@end
