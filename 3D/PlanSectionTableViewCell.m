//
//  PlanSectionTableViewCell.m
//  Orca Care
//
//  Created by Cole Herrmann on 12/17/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "PlanSectionTableViewCell.h"
#import "MultipleChoiceTableView.h"

@interface PlanSectionTableViewCell ()

@property (weak, nonatomic, readwrite) IBOutlet UILabel *planSectionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellCircle;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *downArrow;
@property (weak, nonatomic) UITableView *tableView;


@end

@implementation PlanSectionTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)openCellWithTableView:(UITableView *)tableView forRowHeight:(CGFloat)rowHeight
{
    self.tableView = tableView;
    
    self.tableView.alpha = 0;
    
    self.tableView.frame = CGRectMake(CGRectGetMaxX(self.cellCircle.frame),
                                      CGRectGetMaxY(self.subtitleLabel.frame) + 15,
                                      (self.contentView.frame.size.width - CGRectGetMaxX(self.cellCircle.frame)) - 5,
                                      rowHeight - CGRectGetMaxY(self.subtitleLabel.frame));

    [self.contentView addSubview:self.tableView];
    
    [UIView animateWithDuration:0.55 animations:^{
        self.tableView.alpha = 1;
        self.downArrow.alpha = 1;
        self.subtitleLabel.alpha = 1;
    }];
}


-(void)closeCellRemoveCollectionView:(void (^)())completion
{
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
    
    [UIView animateWithDuration:0.14 animations:^{
        self.tableView.alpha = 0;
        self.downArrow.alpha = 0;
        self.subtitleLabel.alpha = 0;
        
    }completion:^(BOOL finished) {
        [self.tableView removeFromSuperview];
        self.tableView = nil;
        if(completion)
            completion();
    }];
   
}

@end
