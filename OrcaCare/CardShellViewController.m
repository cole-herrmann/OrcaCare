//
//  WalkthroughShellViewController.m
//  OrcaWalkthrough
//
//  Created by Chad Zeluff on 10/2/14.
//  Copyright (c) 2014 orcahealth. All rights reserved.
//

#import "CardShellViewController.h"

@interface CardShellViewController() <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *lastConstraints;
//@property (nonatomic, readonly) int currentPage;
//@property (nonatomic) CGFloat scrollOffsetRotation;

@property (nonatomic, strong) NSMutableArray *views;
//@property (nonatomic) NSInteger totalSteps;
//@property (nonatomic, strong) NSArray *ranges;

@end

@implementation CardShellViewController

- (instancetype)init {
    self = [super init];
    
    if(!self) return nil;
    
    [self commonInit];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if(!self) return nil;
    
    [self commonInit];
    
    return self;
}

- (void)commonInit {
//    _scrollOffsetRotation = 0;
//    _totalSteps = 0;
    self.views = [NSMutableArray array];
    self.scrollView = [[UIScrollView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.clipsToBounds = NO;
    [self.view insertSubview:self.scrollView atIndex:0];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *viewsDictionary = @{@"sv":self.scrollView};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[sv]-0-|" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[sv]-0-|" options:0 metrics:nil views:viewsDictionary]];    
}

- (void)addView:(UIView *)view {
    [self.views addObject:view];
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:view];
    
    NSDictionary *viewsDictionary = @{@"vcView" : view, @"selfView" : self.view};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[vcView(==selfView)]" options:0 metrics:nil views:viewsDictionary]];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                    attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.view
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:1.0
                                                                          constant:-8.0];
    
    [self.view addConstraint: widthConstraint];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[vcView(==selfView)]" options:0 metrics:nil views:viewsDictionary]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[vcView]|" options:0 metrics:nil views:viewsDictionary]];
    
    if([self.views count] == 1) {
        [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-4-[vcView]" options:0 metrics:nil views:viewsDictionary]];
    } else {
        UIView *previousView = self.views[self.views.count - 2];
        [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[pv]-8-[v]" options:0 metrics:nil views:@{@"pv" : previousView, @"v" : view}]];
        
        if(self.lastConstraints) {
            [self.scrollView removeConstraints:self.lastConstraints];
        }
        
        self.lastConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[v]-4-|" options:0 metrics:nil views:@{@"v" : view}];
        [self.scrollView addConstraints:self.lastConstraints];
    }

}

/*
- (void)addViewController:(UIViewController *)vc {
    [self.controllers addObject:vc];
    
    //It's easier to deny non-WalkthroughPage-conforming VC's from entering the array than it is to check everywhere else that the page conforms before proceeding.
    if(![vc conformsToProtocol:@protocol(WalkthroughPage)]) {
        NSAssert(NO, @"Every page you add must conform to this protocol");
        return;
    }
    
    UIViewController<WalkthroughPage> *walkthroughPage = (UIViewController<WalkthroughPage> *)vc;
    self.totalSteps += [walkthroughPage numberOfSteps];
    
    vc.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:vc.view];
    
    NSDictionary *viewsDictionary = @{@"vcView" : vc.view, @"selfView" : self.view};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[vcView(==selfView)]" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[vcView(==selfView)]" options:0 metrics:nil views:viewsDictionary]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[vcView]|" options:0 metrics:nil views:viewsDictionary]];
    
    if([self.controllers count] == 1) {
        [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[vcView]" options:0 metrics:nil views:viewsDictionary]];
    } else {
        UIViewController *previousVC = self.controllers[self.controllers.count - 2];
        UIView *previousView = previousVC.view;
        [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[pv]-0-[v]" options:0 metrics:nil views:@{@"pv" : previousView, @"v" : vc.view}]];
        
        if(self.lastConstraints) {
            [self.scrollView removeConstraints:self.lastConstraints];
        }
        
        self.lastConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[v]-0-|" options:0 metrics:nil views:@{@"v" : vc.view}];
        [self.scrollView addConstraints:self.lastConstraints];
    }
}
 */

//- (int)currentPage {
//    return (int)(self.scrollView.contentOffset.x / self.view.bounds.size.width);
//}

/*
- (void)calculateMoveableRanges {
    NSMutableArray *ranges = [NSMutableArray array];
    CGFloat width = self.view.bounds.size.width;
    CGFloat previousWidths = 0;
    [ranges addObject:@(-width)];
    for(int i = 0; i < [self.controllers count]; i++) {
        
        UIViewController<WalkthroughPage> *walkthroughPage = self.controllers[i];
        NSInteger steps = walkthroughPage.numberOfSteps;
        CGFloat range = ((steps-1) * width) + previousWidths;
        previousWidths += (steps * width);
        [ranges addObject:@(range)];
    }
    
    self.ranges = [ranges copy];
    
    //DEBUG
//    for(int i = 0; i < [ranges count]; i++) {
//        NSNumber *range = ranges[i];
//        NSLog(@"Range %d Start: %@", i, range);
//    }
}
 */

/*
- (void)updatedParentScrollView:(UIScrollView *)parentScrollView {
    //Tell all views that are coming on / going off-screen, or are currently visible
    int previousSteps = 0;
    for(int i = 0; i < [self.controllers count]; i++) {
        UIViewController<WalkthroughPage> *walkthroughPage = self.controllers[i];
        CGFloat width = self.view.bounds.size.width;
        CGFloat offset = (parentScrollView.contentOffset.x - (width * previousSteps)) / width;
        if(offset <= walkthroughPage.numberOfSteps && offset >= -1.0) {
            [walkthroughPage walkthroughDidScrollToPosition:parentScrollView.contentOffset.x offset:offset];
        }
        previousSteps += walkthroughPage.numberOfSteps;
    }
    
    //Figure out whether or not we should scroll our scrollview
    BOOL shouldScroll = NO;
    int numberOfPages = 0;
    CGFloat parentOffset = parentScrollView.contentOffset.x;
    CGFloat width = self.view.bounds.size.width;
    for(int i = 0; i < [self.ranges count]; i++) {
        CGFloat beginningRange = [self.ranges[i] floatValue];
        CGFloat endingRange = beginningRange + width;
        if(parentOffset >= beginningRange && parentOffset <= endingRange) {
            shouldScroll = YES;
            numberOfPages = i;
            break;
        }
    }
    
    //numberOfPages tells us how many pages we need to use total up from the previous pages
    if(shouldScroll) {
        int totalSteps = 0;
        for(int i = 0; i < numberOfPages; i++) {
            UIViewController<WalkthroughPage> *walkthroughPage = self.controllers[i];
            totalSteps += walkthroughPage.numberOfSteps;
        }
        
        CGFloat newOffset = parentOffset - (width * (totalSteps - numberOfPages));
        self.scrollView.contentOffset = CGPointMake(newOffset, 0);
    }
}
 */

//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
//    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
//
//    self.scrollOffsetRotation = self.currentPage * size.width; //Store away where the scrollView *needs* to go.
//}

//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    
////    [self calculateMoveableRanges];
//    self.scrollView.contentOffset = CGPointMake(self.scrollOffsetRotation, 0); //We can simply set the content offset now that the contentSize is correct.
//}

@end
