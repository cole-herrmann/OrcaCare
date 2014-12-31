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
#import "OrcaObject.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Media.h"
#import "RehabAssignment.h"
#import "Rehab.h"
#import <MediaPlayer/MediaPlayer.h>
#import <URBMediaFocusViewController/URBMediaFocusViewController.h>
#import "BubbleTransition.h"
#import "TimelineTableViewCell.h"
#import <POP+MCAnimate.h>

NSString *const diagnosis = @"D I A G N O S I S";
NSString *const treatment = @"T R E A T M E N T";
NSString *const recovery = @"R E C O V E R Y";
NSString *const handouts = @"H A N D O U T S";


@interface PlanSectionsViewController () <UITableViewDataSource, UITableViewDelegate, URBMediaFocusViewControllerDelegate, BubbleTransitionProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) CGFloat expandedCellHeight;
@property (nonatomic, retain) NSIndexPath *expandedCellIndexPath;
@property (nonatomic, strong) URBMediaFocusViewController *mediaVC;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (nonatomic, strong) NSMutableArray *sectionsArray;
@property (nonatomic, strong) NSArray *multipleChoiceDataSource;
@property (nonatomic, strong) NSArray *recoveryDataSource;
@property (nonatomic, strong) OrcaObject *orcaObjectForContent;
@property (nonatomic, strong) MPMoviePlayerViewController *playerVC;

@end

@implementation PlanSectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.closeButton.alpha = 0;
    
    [self makeHeaderGradient];
    
    self.tableView.contentInset = UIEdgeInsetsMake(self.headerView.bounds.size.height, 0, 0, 0);
}

- (void)viewDidAppear:(BOOL)animated {
    self.closeButton.pop_duration = 0.4;
    self.closeButton.pop_linear.alpha = 1;
}
- (IBAction)close:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if([tableView isEqual:self.tableView]){
        
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
    if([tableView isEqual:self.tableView]){
        return 4;//[self numberOfRowsForMainTableView];
    }else if([tableView isKindOfClass:[MultipleChoiceTableView class]]){
        return 2;//[self.multipleChoiceDataSource count];
    }else if([tableView isKindOfClass:[ContentTableView class]]){
        return 4;//[self.orcaObjectForContent.media count];
    }else{
        return 3;//[self.recoveryDataSource count];
    }
}

-(NSInteger)numberOfRowsForMainTableView
{
    NSInteger rows = 0;
    
    if([self.encounter.diagnoses count] > 0){
        [self.sectionsArray addObject:@{@"title" : diagnosis, @"imageName" : @"steth", @"content" : self.encounter.diagnoses}];
        rows += 1;
    }
    
    if([self.encounter.treatments count] > 0){
        [self.sectionsArray addObject:@{@"title" : treatment, @"imageName" : @"bandaid", @"content" : self.encounter.treatments}];
        rows += 1;
    }
    
    if([self.encounter.rehabAssignments count] > 0){
        [self.sectionsArray addObject:@{@"title" : recovery, @"imageName" : @"crutch", @"content" : self.encounter.rehabAssignments}];

      rows += 1;
    }

    if([self.encounter.handouts count] > 0 || [self.encounter.media count] > 0|| [self.encounter.customMedia count] > 0 || [self.encounter.notes count] > 0){
        [self.sectionsArray addObject:@{@"title" : handouts, @"imageName" : @"handout"}];
        rows += 1;
    }
    
    return rows;
}


#pragma mark tableview based cellforRowAtIndexPath

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:self.tableView]){
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
    
//    cell.planSectionLabel.text = [self.sectionsArray[indexPath.row] valueForKey:@"title"];
//    cell.cellCircle.image = [UIImage imageNamed:(NSString *)[self.sectionsArray[indexPath.row] valueForKey:@"imageName"]];
    
    if(indexPath.row == 0){
        cell.planSectionLabel.text = diagnosis;
        cell.cellCircle.image = [UIImage imageNamed:@"steth"];
    }else if(indexPath.row == 1){
        cell.planSectionLabel.text = treatment;
        cell.cellCircle.image = [UIImage imageNamed:@"bandaid"];
    }else if(indexPath.row == 2){
        cell.planSectionLabel.text = recovery;
        cell.cellCircle.image = [UIImage imageNamed:@"crutch"];
    }else if(indexPath.row == 3){
        cell.planSectionLabel.text = handouts;
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
    
//    OrcaObject *orcaObject = self.multipleChoiceDataSource[indexPath.row];
//    cell.title.text = orcaObject.name;
    
    if(indexPath.row % 2 == 0)
    {
        cell.title.text = @"Lumbar Disc Herniation";
    }else{
        cell.title.text = @"Spine Fracture";
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
    
    if(indexPath.row == 0){
        cell.title.text = @"Lumbar Disc Herniation";
    }else if(indexPath.row == 1){
        cell.thumbnailImageView.image = [UIImage imageNamed:@"abnormal"];
        cell.title.text = @"Abnormal Disc";
    }else if(indexPath.row == 2){
        cell.thumbnailImageView.image = [UIImage imageNamed:@"normal"];
        cell.title.text = @"Normal Disc";
    }else if(indexPath.row == 3){
        cell.thumbnailImageView.image = nil;
        cell.thumbnailImageView.backgroundColor = [UIColor colorWithRed:0.031 green:0.290 blue:0.522 alpha:0.5];
        cell.title.text = @"Lumbar Disc Herniation Description";
    }


//    Media *m = self.orcaObjectForContent.media[indexPath.row];
//    
//    cell.title.text = m.name;
//    
//    NSString *photoUrl = [NSString stringWithFormat:@"https:%@", m.thumbUrl];
//    [cell.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:photoUrl]
//                          placeholderImage:nil];
    
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
    
    
//    RehabAssignment *rehabAssignment = self.recoveryDataSource[indexPath.row];
//    Rehab *rehab = rehabAssignment.rehab;
//    cell.title.text = rehab.name;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}


#pragma mark tableview based didSelectRowAtIndexPath

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if([tableView isEqual:self.tableView]){
       
        [self selectedRowForSectionsTableView:tableView indexPath:indexPath];
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    
    }else if([tableView isKindOfClass:[MultipleChoiceTableView class]]){
        
        PlanSectionTableViewCell *cell = (PlanSectionTableViewCell *)[self.tableView cellForRowAtIndexPath:self.expandedCellIndexPath];
        
//        self.orcaObjectForContent = self.multipleChoiceDataSource[indexPath.row];
//        self.multipleChoiceDataSource = nil;
       
        [cell closeCellRemoveCollectionView:^{
            
            [self addTableViewToCellWithNibName:@"ContentTableView"
                                    withCellNibName:@"ContentTableViewCell"
                            withReuseIdentifier:@"ContentTableViewCell"
                                         toCell:cell];
            
            [self.tableView beginUpdates];
            [self.tableView endUpdates];
        }];
        
    }else if([tableView isKindOfClass:[ContentTableView class]]){
        
        self.mediaVC = [[URBMediaFocusViewController alloc]init];
        self.mediaVC.shouldDismissOnImageTap = YES;
        
        NSString *imageName;
        if(indexPath.row == 0){
           imageName = @"spine";
        }else if(indexPath.row == 1){
            imageName = @"abnormal";
        }else if(indexPath.row == 2){
            imageName = @"normal";
        }
        
        [self.mediaVC showImage:[UIImage imageNamed:imageName] fromView:[tableView cellForRowAtIndexPath:indexPath]];

//
//        Media *m = self.orcaObjectForContent.media[indexPath.row];
//        if([m.fileContentType  isEqual: @"video/mp4"]){
//            
//            NSString *videoUrlString = [NSString stringWithFormat:@"https:%@", m.fullUrl];
//            NSURL *videoUrl = [NSURL URLWithString:videoUrlString];
//            self.playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:videoUrl];
//            self.playerVC.view.alpha = 0.0;
//            [self addChildViewController:self.playerVC];
//            [self.view addSubview:self.playerVC.view];
//            
//            [UIView animateWithDuration:0.4 animations:^{
//                self.playerVC.view.alpha = 1.0;
//            }];
//            
//            [[NSNotificationCenter defaultCenter] addObserver:self
//                                                     selector:@selector(movieDone:)
//                                                         name:MPMoviePlayerPlaybackDidFinishNotification
//                                                       object:nil];
//            
////            [self.mediaVC showImageFromURL:videoUrl fromView:[tableView cellForRowAtIndexPath:indexPath]];
//            
//        }else{
//            NSString *photoUrlString = [NSString stringWithFormat:@"https:%@", m.fullUrl];
//            NSURL *photoUrl = [NSURL URLWithString:photoUrlString];
//            
//            [self.mediaVC showImageFromURL:photoUrl fromView:[tableView cellForRowAtIndexPath:indexPath]];
//        }
       
    
    }else if([tableView isKindOfClass:[RecoveryTableView class]]){
        NSURL *videoUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"recoveryVideo" ofType:@"mp4"]];

        self.playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:videoUrl];
        self.playerVC.view.alpha = 0.0;
        [self addChildViewController:self.playerVC];
        [self.view addSubview:self.playerVC.view];

        [UIView animateWithDuration:0.4 animations:^{
            self.playerVC.view.alpha = 1.0;
        }];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(movieDone:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];

//            [self.mediaVC showImageFromURL:videoUrl fromView:[tableView cellForRowAtIndexPath:indexPath]];
    }
    
}

-(void)movieDone:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.playerVC.view.alpha = 0.0;
    }];
}


-(void)selectedRowForSectionsTableView:(UITableView*)tableView indexPath:(NSIndexPath *)indexPath
{
    PlanSectionTableViewCell *cell = (PlanSectionTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
//    NSDictionary *selectedDictionary = self.sectionsArray[indexPath.row];

    //if the selected cell is already open, close it.
    if([indexPath isEqual:self.expandedCellIndexPath]){
        
        [cell closeCellRemoveCollectionView:nil];
        self.expandedCellHeight = 90;
        self.expandedCellIndexPath = nil;
        
    }else{
        
        //if there is an open cell, close it before opening new one.
        if(self.expandedCellIndexPath != nil){
            [(PlanSectionTableViewCell *)[tableView cellForRowAtIndexPath:self.expandedCellIndexPath] closeCellRemoveCollectionView:nil];
        }
        
//        NSString *cellTitle = [selectedDictionary valueForKey:@"title"];
        
        if(indexPath.row == 0/*[[selectedDictionary valueForKey:@"content"] count] > 1 && (cellTitle == diagnosis || cellTitle == treatment)*/){
           
//            self.multipleChoiceDataSource = [selectedDictionary valueForKey:@"content"];
            
            [self addTableViewToCellWithNibName:@"MultipleChoiceTableView"
                                    withCellNibName:@"MutlipleChoiceTableViewCell"
                            withReuseIdentifier:@"MultipleChoiceCell"
                                         toCell:cell];
            
        }else if(indexPath.row == 1 || indexPath.row == 3/*[[selectedDictionary valueForKey:@"content"] count] == 1 && (cellTitle == diagnosis || cellTitle == treatment)*/){
            
//            self.orcaObjectForContent = [[selectedDictionary valueForKey:@"content"] firstObject];
            
            [self addTableViewToCellWithNibName:@"ContentTableView"
                                withCellNibName:@"ContentTableViewCell"
                            withReuseIdentifier:@"ContentTableViewCell"
                                         toCell:cell];
            
        }else if(indexPath.row == 2){
            
//            self.recoveryDataSource = [selectedDictionary valueForKey:@"content"];

            [self addTableViewToCellWithNibName:@"RecoveryTableView"
                                    withCellNibName:@"RecoveryTableViewCell"
                            withReuseIdentifier:@"RecoveryTableViewCell"
                                         toCell:cell];
        }/*else{
            [self addTableViewToCellWithNibName:@"ContentTableView"
                                    withCellNibName:@"ContentTableViewCell"
                            withReuseIdentifier:@"ContentTableViewCell"
                                         toCell:cell];
        }*/
        
        self.expandedCellIndexPath = indexPath;
    }
}

-(void)addTableViewToCellWithNibName:(NSString *)nibName
                         withCellNibName:(NSString *)cellNibName
                 withReuseIdentifier:(NSString *)reuseIdentifier
                              toCell:(PlanSectionTableViewCell *)cell
{
    UITableView *tableView = [[[NSBundle mainBundle] loadNibNamed:nibName
                                                            owner:self
                                                          options:nil] firstObject];
    
    UINib *cellNib = [UINib nibWithNibName:cellNibName bundle:nil];
    [tableView registerNib:cellNib forCellReuseIdentifier:reuseIdentifier];
    
    tableView.delegate = self;
    tableView.dataSource =self;
    tableView.backgroundColor = [UIColor clearColor];
    self.expandedCellHeight = tableView.rowHeight * [tableView numberOfRowsInSection:0] + 80;
    
    [cell openCellWithTableView:tableView forRowHeight:self.expandedCellHeight];
}

- (UITableView *)tableViewToBubble {
    return self.tableView;
}

- (void)handleSnapshot:(UIView *)view {
    [self.headerView addSubview:view];
}

- (void)modifyViewForHeaderUse:(UIView *)view {
    TimelineTableViewCell *cell = (TimelineTableViewCell *)view;
//    cell.backgroundColor = [UIColor redColor];
    CGFloat headerHeight = self.headerView.bounds.size.height;
    CGRect frame = cell.frame;
    frame.size.height = headerHeight;
    cell.frame = frame;
    cell.pop_spring.frame = cell.bounds;
    cell.doctorPicture.pop_linear.pop_scaleXY = CGPointMake(0.7, 0.7);
    cell.doctorLabel.pop_spring.center = CGPointMake(170, headerHeight/2);
    cell.dateLabel.pop_duration = 0.2;
    cell.dateLabel.pop_linear.alpha = 0.0f;
}

@end
