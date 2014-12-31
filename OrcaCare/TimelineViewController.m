//
//  TimelineViewController.m
//  Orca Care
//
//  Created by Cole Herrmann on 12/17/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "TimelineViewController.h"
#import "TimelineTableViewCell.h"
#import "BubbleTransition.h"
#import "EncounterViewModel.h"
#import "PlanSectionsViewController.h"
#import "Provider.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate, BubbleTransitionProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, weak) IBOutlet UIView *viewInHeader;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (nonatomic, weak) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) NSArray *upCells;
@property (nonatomic, strong) NSArray *downCells;
@property (nonatomic, strong) BubbleTransition *transition;

@property (nonatomic, strong) EncounterViewModel *encounterVM;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeHeaderGradient];
    self.transition = [[BubbleTransition alloc] initWithNavigationController:self.navigationController];
    self.tableView.contentInset = UIEdgeInsetsMake(self.headerView.bounds.size.height, 0, 0, 0);
    
//    self.encounterVM = [EncounterViewModel singleton];
}

- (void)makeHeaderGradient {
    
    UIColor *firstColor = [UIColor whiteColor];
    UIColor *secondColor = [UIColor colorWithWhite:1 alpha:.7];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = [NSArray arrayWithObjects: (id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    
    gradient.frame = self.headerView.bounds;
    gradient.startPoint = CGPointMake(0.5, 0.75);
    gradient.endPoint = CGPointMake(0.5, 1.1);
    
    [self.headerView.layer insertSublayer:gradient atIndex:0];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;//[self.encounterVM.encounters count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIdentifier = @"TimelineCell";
    TimelineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[TimelineTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
//    Encounter *encounter = self.encounterVM.encounters[indexPath.row];
//    Provider *provider = encounter.provider;
//    
//    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:encounter.createdDate];
//    NSInteger day = [components day];
//    NSInteger month = [components month];
//    NSInteger year = [components year];
//    
//    cell.doctorLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@", provider.prefix, provider.firstName, provider.lastName, provider.suffix];
//    cell.dateLabel.text = [NSString stringWithFormat:@"%ld • %ld • %ld", (long)month, (long)day, (long)year];
//    NSString *photoUrl = [NSString stringWithFormat:@"https:%@", provider.photoURL];
//    [cell.doctorPicture sd_setImageWithURL:[NSURL URLWithString:photoUrl]
//                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    
    if(indexPath.row == 0){
        
        cell.doctorPicture.image = [UIImage imageNamed:@"docpic"];
        cell.doctorLabel.text = @"Dr. Chad Zeluff";
        cell.dateLabel.text = @"10 • 22 • 2014";
        
    }else if(indexPath.row == 1){
        
        cell.doctorPicture.image = [UIImage imageNamed:@"drli"];
        cell.doctorLabel.text = @"Dr. Li Hashimoto";
        cell.dateLabel.text = @"7 • 12 • 2013";
        
    }else if(indexPath.row == 2){
        
        cell.doctorPicture.image = [UIImage imageNamed:@"mark"];
        cell.doctorLabel.text = @"Dr. Mark Johnson";
        cell.dateLabel.text = @"4 • 8 • 2011";
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.selectedIndexPath = [self.tableView indexPathForSelectedRow];
    
//    PlanSectionsViewController *psvc = (PlanSectionsViewController *)segue.destinationViewController;
//    Encounter *e = self.encounterVM.encounters[self.selectedIndexPath.row];
//    psvc.encounter = self.encounterVM.encounters[self.selectedIndexPath.row];
    
    NSArray *visibleIndexPaths = [self.tableView indexPathsForVisibleRows];
    NSIndexPath *lowestIndexPath = [visibleIndexPaths firstObject];
    NSIndexPath *highestIndexPath = [visibleIndexPaths lastObject];
    
    NSMutableArray *upCells = [NSMutableArray array];
    NSMutableArray *downCells = [NSMutableArray array];
    
    //The header always moves up
    [upCells addObject:self.viewInHeader];
    
    for(NSInteger i = lowestIndexPath.row; i <= self.selectedIndexPath.row; i++) {
        [upCells addObject:[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
    }
    
    for(NSInteger i = self.selectedIndexPath.row+1; i <= highestIndexPath.row; i++) {
        [downCells addObject:[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
    }
    
    self.upCells = [NSArray arrayWithArray:upCells];
    self.downCells = [NSArray arrayWithArray:downCells];
}

- (UITableView *)tableViewToBubble {
    return self.tableView;
}

- (NSArray *)slideUpViews {
    return self.upCells;
}

- (NSArray *)slideDownViews {
    return self.downCells;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
}

@end
