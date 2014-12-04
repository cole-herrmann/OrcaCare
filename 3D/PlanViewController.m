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
#import "CheckupsViewController.h"
#import "RefreshView.h"

@interface PlanViewController () <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>

//@property (nonatomic, weak) UIImageView *numberedLinesView;
@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic, strong) NSArray *colorsArray;

@property (nonatomic, weak) IBOutlet RefreshView *refreshView;

@property (nonatomic) BOOL animationBegan;

@end

@implementation PlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"numberedlines"]];
////    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:imageView];
//    imageView.frame = CGRectMake(20, 0, 90, self.view.bounds.size.height);
//    self.numberedLinesView = imageView;
    
    self.textArray = @[@"Diagnosis", @"Treatment", @"Recovery", @"Checkup"];
    self.colorsArray = @[[UIColor colorWithRed:8/255.0f green:74/255.0f blue:133/255.0f alpha:.85], [UIColor colorWithRed:1/255.0f green:138/255.0f blue:139/255.0f alpha:.85], [UIColor colorWithRed:50/255.0f green:33/255.0f blue:58/255.0f alpha:.85], [UIColor colorWithRed:70/255.0f green:172/255.0f blue:194/255.0f alpha:.85]];
    
    [[NSBundle mainBundle] loadNibNamed:@"RefreshView" owner:self options:nil];

    CGRect frame = self.refreshView.frame;
    frame.origin = CGPointMake(0, -self.refreshView.bounds.size.height);
    self.refreshView.frame = frame;
    [self.view addSubview:self.refreshView];
    self.refreshView.backgroundColor = [self.colorsArray firstObject];
    [self.refreshView.progressLayer addAnimation:[self pullDownAnimation] forKey:@"fill circle as you drag"];
    self.refreshView.progressLayer.speed = 0.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.textArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *encounterCellIdentifier = @"EncounterCellIdentifier";
    EncounterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:encounterCellIdentifier];
    
    cell.backgroundColor = self.colorsArray[indexPath.row];
    cell.titleLabel.text = self.textArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EncounterTableViewCell *cell = (EncounterTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if(indexPath.row == 3) {
        [self performSegueWithIdentifier:@"checkupSegue" sender:cell];
    } else {
        [self performSegueWithIdentifier:@"diagnosisSegue" sender:cell];
    }
}

- (NSArray *)visibleCells {
    NSArray *cells = [self.tableView visibleCells];
    NSMutableArray *labels = [NSMutableArray arrayWithCapacity:cells.count];
    for(EncounterTableViewCell *cell in cells) {
        [labels addObject:cell.titleLabel];
    }
//    [labels addObject:self.numberedLinesView];
    return labels;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(EncounterTableViewCell *)sender {
    if([segue.identifier isEqualToString:@"diagnosisSegue"]) {
        self.navigationController.delegate = self;
        DiagnosisDetailsViewController *detailsVC = [segue destinationViewController];
        detailsVC.view.backgroundColor = sender.backgroundColor;
        detailsVC.titleLabel.text = sender.titleLabel.text;
    } else if ([segue.identifier isEqualToString:@"checkupSegue"]) {
        self.navigationController.delegate = self;
        CheckupsViewController *checkupVC = [segue destinationViewController];
        checkupVC.view.backgroundColor = sender.backgroundColor;
        checkupVC.titleLabel.text = sender.titleLabel.text;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC
{
    return [AMWaveTransition transitionWithOperation:operation andTransitionType:AMWaveTransitionTypeBounce];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.refreshView.progressLayer.timeOffset = (-(scrollView.contentOffset.y / 120));
   
    if(scrollView.contentOffset.y <= -120){
        
        if(!self.animationBegan) {
            self.animationBegan = YES;
            [UIView animateWithDuration:0.4 animations:^{
                self.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
            } completion:^(BOOL finished) {
                if([self.delegate respondsToSelector:@selector(planVCShouldDismiss:)]) {
                    [self.delegate planVCShouldDismiss:self];
                }
                self.animationBegan = NO;
            }];
        }
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
