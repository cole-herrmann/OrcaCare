//
//  PlanSectionsViewController.m
//  Orca Care
//
//  Created by Cole Herrmann on 12/17/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "PlanSectionsViewController.h"
#import "PlanSectionTableViewCell.h"
#import "ContentView.h"
#import "ContentCollectionViewCellNew.h"
#import "ContentTableView.h"
#import "ContentTableViewCell.h"
#import "MultipleChoiceTableView.h"
#import "MultipleChoiceTableViewCell.h"
#import "RecoveryTableViewCellNew.h"
#import "RecoveryTableView.h"
#import <URBMediaFocusViewController/URBMediaFocusViewController.h>

@interface PlanSectionsViewController () <UITableViewDataSource, UITableViewDelegate, URBMediaFocusViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) CGFloat expandedCellHeight;
@property (nonatomic, retain) NSIndexPath *expandedCellIndexPath;
@property (nonatomic, strong) URBMediaFocusViewController *mediaVC;

@end

@implementation PlanSectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if(tableView == self.tableView){
        
        CGFloat cellHeight = 90;
        
        if ([self.expandedCellIndexPath isEqual:indexPath]) {
            
            cellHeight = self.expandedCellHeight;
            
        }
        
        return cellHeight;
        
    }else if([tableView isKindOfClass:[MultipleChoiceTableView class]]){
        
        return 48;
    
    }else if([tableView isKindOfClass:[ContentTableView class]]){
    
        return 80;
    
    }else{
        return 115;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.tableView){
        return 4;
    }else if([tableView isKindOfClass:[MultipleChoiceTableView class]]){
        return 2;
    }else if([tableView isKindOfClass:[ContentTableView class]]){
        return 4;
    }else{
        return 4;
    }
}


#pragma mark tableview based cellforRowAtIndexPath

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tableView){
        return [self configureSectionsTableView:tableView indexPath:indexPath];
    }else if([tableView isKindOfClass:[MultipleChoiceTableView class]]){
        return [self configureMultipleChoicCell:tableView indexPath:indexPath];
    }else if([tableView isKindOfClass:[ContentTableView class]]){
        return [self configureContentCell:tableView indexPath:indexPath];
    }else{
        return [self configureRecoveryTableView:tableView indexPath:indexPath];
    }
}


-(UITableViewCell *)configureSectionsTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"PlanSectionTableViewCell";
    PlanSectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[PlanSectionTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    if(indexPath.row == 0){
        cell.planSectionLabel.text = @"D I A G N O S I S";
        cell.cellCircle.image = [UIImage imageNamed:@"steth"];
    }else if(indexPath.row == 1){
        cell.planSectionLabel.text = @"T R E A T M E N T";
        cell.cellCircle.image = [UIImage imageNamed:@"bandaid"];
    }else if(indexPath.row == 2){
        cell.planSectionLabel.text = @"R E C O V E R Y";
        cell.cellCircle.image = [UIImage imageNamed:@"crutch"];
    }else if(indexPath.row == 3){
        cell.planSectionLabel.text = @"H A N D O U T S";
        cell.cellCircle.image = [UIImage imageNamed:@"handout"];
    }
    
    return cell;
}

-(UITableViewCell *)configureMultipleChoicCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIdentifier = @"MultipleChoiceCell";
    MultipleChoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MultipleChoiceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(indexPath.row % 2 == 0){
        cell.title.text = @"Lumbar Disc Herniation";
    }else{
        cell.title.text = @"Lumbar Spine Fracture";
    }
    
    return cell;
}


-(UITableViewCell *)configureContentCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"ContentTableViewCell";
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[ContentTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    if(indexPath.row % 2 == 0){
        cell.title.text = @"Lumbar Disc Herniation";
    }else{
        cell.thumbnailImageView.image = [UIImage imageNamed:@"abnormal"];
        cell.title.text = @"Abnormal Disc";
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(UITableViewCell *)configureRecoveryTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"RecoveryTableViewCell";
    RecoveryTableViewCellNew *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[RecoveryTableViewCellNew alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.title.text = @"Lumbar Stretch";
    cell.firstDetail.text = @"3 reps";
    cell.secondDetail.text = @"2 sets";
    cell.thirdDetail.text = @"1 time per day";
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}


#pragma mark tableview based didSelectRowAtIndexPath

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(tableView == self.tableView){
       
        [self selectedRowForSectionsTableView:tableView indexPath:indexPath];
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    
    }else if([tableView isKindOfClass:[MultipleChoiceTableView class]]){
        
        PlanSectionTableViewCell *cell = (PlanSectionTableViewCell *)[self.tableView cellForRowAtIndexPath:self.expandedCellIndexPath];
       
        [cell closeCellRemoveCollectionView:^{
            
            [self addContentTableViewToCell:cell indexPath:self.expandedCellIndexPath];
            
            [self.tableView beginUpdates];
            [self.tableView endUpdates];
        }];
    }else if([tableView isKindOfClass:[ContentTableView class]]){
        
        self.mediaVC = [[URBMediaFocusViewController alloc]init];
        self.mediaVC.shouldDismissOnImageTap = YES;
        NSString *imageName = (indexPath.row % 2 == 0) ? @"spine" : @"abnormal";
        [self.mediaVC showImage:[UIImage imageNamed:imageName] fromView:[tableView cellForRowAtIndexPath:indexPath]];
    
    }
    
}


-(void)selectedRowForSectionsTableView:(UITableView*)tableView indexPath:(NSIndexPath *)indexPath
{
    PlanSectionTableViewCell *cell = (PlanSectionTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];

    //if the selected cell is already open, close it.
    if(indexPath == self.expandedCellIndexPath){
        
        [cell closeCellRemoveCollectionView:nil];
        self.expandedCellHeight = 90;
        self.expandedCellIndexPath = nil;
        
    }else{
        
        //if there is an open cell, close it before opening new one.
        if(self.expandedCellIndexPath != nil){
            [(PlanSectionTableViewCell *)[tableView cellForRowAtIndexPath:self.expandedCellIndexPath] closeCellRemoveCollectionView:nil];
        }
        
        if(indexPath.row == 0){
            [self addMultipleChoiceTableViewToCell:cell indexPath:indexPath];
        }else if(indexPath.row == 2){
            [self addRecoveryTableViewToCell:cell indexPath:indexPath];
        }else{
            [self addContentTableViewToCell:cell indexPath:indexPath];
        }
    }
}

-(void)addContentTableViewToCell:(PlanSectionTableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    ContentTableView *ctv = [[[NSBundle mainBundle] loadNibNamed:@"ContentTableView"
                                                           owner:self
                                                         options:nil] firstObject];
    
    ctv.delegate = self;
    ctv.dataSource = self;
    ctv.backgroundColor = [UIColor clearColor];
    
    self.expandedCellIndexPath = indexPath;
    self.expandedCellHeight = ctv.rowHeight * [ctv numberOfRowsInSection:0] + 80;
    
    [cell openCellWithTableView:ctv forRowHeight:self.expandedCellHeight];
   
}

-(void)addMultipleChoiceTableViewToCell:(PlanSectionTableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    MultipleChoiceTableView *mctv = [[[NSBundle mainBundle] loadNibNamed:@"MultipleChoiceTableView"
                                                                   owner:self
                                                                 options:nil] firstObject];
    
    mctv.delegate = self;
    mctv.dataSource = self;
    mctv.backgroundColor = [UIColor clearColor];
    
    self.expandedCellIndexPath = indexPath;
    self.expandedCellHeight = mctv.rowHeight * [mctv numberOfRowsInSection:0] + 80;
    
    [cell openCellWithTableView:mctv forRowHeight:self.expandedCellHeight];
    
}

-(void)addRecoveryTableViewToCell:(PlanSectionTableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    RecoveryTableView *rtv = [[[NSBundle mainBundle] loadNibNamed:@"RecoveryTableView"
                                                                   owner:self
                                                                 options:nil] firstObject];
    
    rtv.delegate = self;
    rtv.dataSource = self;
    rtv.backgroundColor = [UIColor clearColor];
    
    self.expandedCellIndexPath = indexPath;
    self.expandedCellHeight = rtv.rowHeight * [rtv numberOfRowsInSection:0] + 80;
    
    [cell openCellWithTableView:rtv forRowHeight:self.expandedCellHeight];
    
}


@end
