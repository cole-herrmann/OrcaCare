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
#import "RecoveryViewController.h"

@interface PlanViewController () <UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, EncounterCellDelegate>

//@property (nonatomic, weak) UIImageView *numberedLinesView;
@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic, strong) NSArray *colorsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

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
    
    self.textArray = @[@"Diagnosis", @"Treatments", @"Recovery", @"Handouts"];

    self.colorsArray = @[[UIColor colorWithRed:17/255.0f green:37/255.0f blue:60/255.0f alpha:1], [UIColor whiteColor], [UIColor colorWithRed:70/255.0f green:172/255.0f blue:194/255.0f alpha:1], [UIColor colorWithRed:209/255.0f green:122/255.0f blue:34/255.0f alpha:1]];
    self.view.backgroundColor = [UIColor colorWithRed:8/255.0f green:74/255.0f blue:133/255.0f alpha:.85];
    
//    [self.titleLabel setTextColor:self.colorsArray[0]];

//    UIImage *downArrow = [[UIImage imageNamed:@"backModal"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    downArrow
//    [self.downArrowButton setImage:[[UIImage imageNamed:@"backModal"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
}

- (IBAction)dismiss:(id)sender {
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
    
    if([cell.cardView.backgroundColor isEqual:[UIColor whiteColor]]) {
        [cell.titleLabel setTextColor:[UIColor colorWithRed:8/255.0f green:74/255.0f blue:133/255.0f alpha:1]];
    } else {
        [cell.titleLabel setTextColor:[UIColor whiteColor]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellHeight = tableView.bounds.size.height / 4;
    if ([self.expandedCellIndexPath isEqual:indexPath]) {
        cellHeight = self.expandedCellHeight;
    }
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    EncounterTableViewCell *cell = (EncounterTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if(indexPath.row == 1) {
        [cell openWithButtonTitles:@[@"Lumbar Microdiscectomy", @"Physical Therapy", @"Epidural Steroid Injections", @"Medications"]];
        self.expandedCellIndexPath = indexPath;
        self.expandedCellHeight = 250; //hard-coded size for now, we should query this size from the cell itself!
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    } else {
        NSString *segue;
        switch (indexPath.row) {
            case 0:
                segue = @"diagnosisSegue";
                break;
            case 2:
                segue = @"recoverySegue";
                break;
            case 3:
                segue = @"diagnosisSegue";
                break;
            default:
                break;
                
            
        }
        [self performSegueWithIdentifier:segue sender:cell];
    }
}

- (void)clickedRow:(NSInteger)row forCell:(EncounterTableViewCell *)cell {
    NSInteger cellRow = [self.tableView indexPathForCell:cell].row;
    [self performSegueWithIdentifier:@"treatmentSegue" sender:cell];
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
    UIColor *color = self.view.backgroundColor;
    
    if([segue.identifier isEqualToString:@"recoverySegue"]) {
        self.navigationController.delegate = self;
        RecoveryViewController *recoveryVC = [segue destinationViewController];
        recoveryVC.view.backgroundColor = color;
        recoveryVC.titleLabel.text = sender.titleLabel.text;
    } else {
        self.navigationController.delegate = self;
        ContentViewController *detailsVC = [segue destinationViewController];
        if([segue.identifier isEqualToString:@"treatmentSegue"]) {
            detailsVC.isTreatment = YES;
        }
        detailsVC.view.backgroundColor = color;
        detailsVC.titleLabel.text = sender.titleLabel.text;
    }
    
//    if([segue.identifier isEqualToString:@"diagnosisSegue"]) {

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

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    
//    self.refreshView.progressLayer.timeOffset = (-(scrollView.contentOffset.y / 120));
//   
//    if(scrollView.contentOffset.y <= -120){
//        
//        if(!self.animationBegan) {
//            self.animationBegan = YES;
//            [UIView animateWithDuration:0.4 animations:^{
//                self.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
//            } completion:^(BOOL finished) {
//                if([self.delegate respondsToSelector:@selector(planVCShouldDismiss:)]) {
//                    [self.delegate planVCShouldDismiss:self];
//                }
//                self.animationBegan = NO;
//            }];
//        }
//    }
//}

//- (CABasicAnimation *)pullDownAnimation
//{
//    // Text is drawn by stroking the path from 0% to 100%
//    CABasicAnimation *fillCircle = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    fillCircle.fromValue = @0;
//    fillCircle.toValue = @1;
//    fillCircle.duration = 1.0f;
//    
//    return fillCircle;
//}

@end
