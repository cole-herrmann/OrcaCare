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
#import "ContentViewController.h"

@interface PlanViewController () <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, EncounterCellDelegate>

//@property (nonatomic, weak) UIImageView *numberedLinesView;
@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic, strong) NSArray *colorsArray;

@property (nonatomic, weak) IBOutlet RefreshView *refreshView;

@property (nonatomic) BOOL animationBegan;

@property (nonatomic, retain) NSIndexPath *expandedCellIndexPath;
@property (nonatomic) CGFloat expandedCellHeight;

@end

@implementation PlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"numberedlines"]];
////    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:imageView];
//    imageView.frame = CGRectMake(20, 0, 90, self.view.bounds.size.height);
//    self.numberedLinesView = imageView;
    
    self.textArray = @[@"Diagnosis", @"Treatment", @"Recovery", @"Handouts"];
    self.colorsArray = @[[UIColor colorWithRed:8/255.0f green:74/255.0f blue:133/255.0f alpha:1.0], [UIColor colorWithRed:61/255.0f green:130/255.0f blue:192/255.0f alpha:1], [UIColor colorWithRed:17/255.0f green:37/255.0f blue:60/255.0f alpha:1], [UIColor colorWithRed:31/255.0f green:68/255.0f blue:99/255.0f alpha:1]];
    
    [[NSBundle mainBundle] loadNibNamed:@"RefreshView" owner:self options:nil];

    CGRect frame = self.refreshView.frame;
    frame.origin = CGPointMake(0, -self.refreshView.bounds.size.height);
    self.refreshView.frame = frame;
    [self.view addSubview:self.refreshView];
    self.view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:.5];
    [self.refreshView.progressLayer addAnimation:[self pullDownAnimation] forKey:@"fill circle as you drag"];
    self.refreshView.progressLayer.speed = 0.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.textArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *encounterCellIdentifier = @"EncounterCellIdentifier";
    EncounterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:encounterCellIdentifier];
    cell.delegate = self;
    cell.backgroundColor = [UIColor clearColor];    
    cell.cardView.backgroundColor = self.colorsArray[indexPath.row];
    cell.titleLabel.text = self.textArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellHeight = self.view.bounds.size.height / 4;
    if ([self.expandedCellIndexPath isEqual:indexPath]) {
        cellHeight = self.expandedCellHeight;
    }
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    EncounterTableViewCell *cell = (EncounterTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if(indexPath.row == 1) {
        [cell openWithButtonTitles:@[@"Treatment A", @"Treatment B"]];
        self.expandedCellIndexPath = indexPath;
        self.expandedCellHeight = 200; //hard-coded size for now, we should query this size from the cell itself!
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }else{
//    
//    if(indexPath.row == 3) {
//        [self performSegueWithIdentifier:@"checkupSegue" sender:cell];
//    } else if(indexPath.row == 0 || indexPath.row == 2) {
        [self performSegueWithIdentifier:@"diagnosisSegue" sender:cell];
    }
}

- (void)clickedRow:(NSInteger)row forCell:(EncounterTableViewCell *)cell {
    NSInteger cellRow = [self.tableView indexPathForCell:cell].row;
}

- (void)closeCell:(EncounterTableViewCell *)sender {
    self.expandedCellIndexPath = nil;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (NSArray *)visibleCells {    
    return [self.tableView visibleCells];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(EncounterTableViewCell *)sender {
    UIColor *color = sender.cardView.backgroundColor;
    color = [color colorWithAlphaComponent:.85];
//    if([segue.identifier isEqualToString:@"diagnosisSegue"]) {
        self.navigationController.delegate = self;
        ContentViewController *detailsVC = [segue destinationViewController];
        detailsVC.view.backgroundColor = color;
        detailsVC.titleLabel.text = sender.titleLabel.text;
//    } else if ([segue.identifier isEqualToString:@"checkupSegue"]) {
//        self.navigationController.delegate = self;
//        CheckupsViewController *checkupVC = [segue destinationViewController];
//        checkupVC.view.backgroundColor = color;
//        checkupVC.titleLabel.text = sender.titleLabel.text;
//    }
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
