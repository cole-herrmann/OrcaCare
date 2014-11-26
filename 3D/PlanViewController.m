//
//  PlanViewController.m
//  3D
//
//  Created by Cole Herrmann on 11/25/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "PlanViewController.h"
#import "TransitionAnimator.h"
#import "AMWaveTransition.h"
#import "EncounterTableViewCell.h"
#import "DiagnosisDetailsViewController.h"

@interface PlanViewController () <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *dismissView;
@property (weak, nonatomic) IBOutlet UIView *progressRing;
@property (weak, nonatomic) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic, strong) NSArray *colorsArray;
@property (nonatomic, strong) NSArray *imageNameArray;

@end

@implementation PlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textArray = @[@"Diagnosis", @"Treatment", @"Recovery", @"Checkup"];
    self.colorsArray = @[[UIColor colorWithRed:8/255.0f green:74/255.0f blue:133/255.0f alpha:.9], [UIColor colorWithRed:1/255.0f green:138/255.0f blue:139/255.0f alpha:.9], [UIColor colorWithRed:255/255.0f green:152/255.0f blue:62/255.0f alpha:.9], [UIColor colorWithRed:10/255.0f green:147/255.0f blue:196/255.0f alpha:.9]];
    self.imageNameArray = @[];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    NSLog(@"%@", NSStringFromCGRect(self.refreshControl.frame));
    
    UIBezierPath * circle = [UIBezierPath bezierPathWithOvalInRect:self.progressRing.bounds];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    self.shapeLayer = shapeLayer;
    shapeLayer.path = circle.CGPath;
    shapeLayer.strokeColor =[[UIColor whiteColor]CGColor];
    shapeLayer.fillColor = [[UIColor clearColor]CGColor];
    [shapeLayer setLineWidth:1.0];
    [self.progressRing.layer addSublayer:shapeLayer];
    [shapeLayer addAnimation:[self pullDownAnimation] forKey:@"fill circle as you drag"];
    shapeLayer.speed = 0.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.textArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *encounterCellIdentifier = @"EncounterCellIdentifier";
    EncounterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:encounterCellIdentifier];
    
    cell.backgroundColor = self.colorsArray[indexPath.row];
    cell.titleLabel.text = self.textArray[indexPath.row];
//    cell.numberImageView.image = [UIImage imageNamed:self.imageNameArray[indexPath.row]];
    
    return cell;
}

- (NSArray *)visibleCells {
    NSArray *cells = [self.tableView visibleCells];
    NSMutableArray *labels = [NSMutableArray arrayWithCapacity:cells.count];
    for(EncounterTableViewCell *cell in cells) {
        [labels addObject:cell.titleLabel];
    }
    
    return labels;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(EncounterTableViewCell *)sender {
    self.navigationController.delegate = self;
    DiagnosisDetailsViewController *detailsVC = [segue destinationViewController];
    detailsVC.view.backgroundColor = sender.backgroundColor;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC
{
    return [AMWaveTransition transitionWithOperation:operation andTransitionType:AMWaveTransitionTypeBounce];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.shapeLayer.timeOffset = (-(scrollView.contentOffset.y / 120));
   
    if(scrollView.contentOffset.y == -120){
       
        [UIView animateWithDuration:0.4 animations:^{
            self.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            if([self.delegate respondsToSelector:@selector(planVCShouldDismiss:)]) {
                [self.delegate planVCShouldDismiss:self];
            }
        }];
    }
}

- (CABasicAnimation *)pullDownAnimation
{
    // Text is drawn by stroking the path from 0% to 100%
    CABasicAnimation *fillCircle = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    fillCircle.fromValue = @0;
    fillCircle.toValue = @1;
    fillCircle.duration = 1.0f;
    
    return fillCircle;
}

@end
