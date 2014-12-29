//
//  PlanSectionTableViewCell.h
//  Orca Care
//
//  Created by Cole Herrmann on 12/17/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentView.h"
#import "ContentTableView.h"

@interface PlanSectionTableViewCell : UITableViewCell

@property (nonatomic, weak, readonly) UILabel *planSectionLabel;
@property (nonatomic, weak, readonly) UIImageView *cellCircle;
@property (weak, nonatomic, readonly) UILabel *subtitleLabel;

-(void)openCellWithTableView:(UITableView *) tableView forRowHeight:(CGFloat)rowHeight;
-(void)closeCellRemoveCollectionView:(void (^)())completion;

@end
