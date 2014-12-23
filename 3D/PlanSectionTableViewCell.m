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
//@property (nonatomic, weak) ContentView *viewWithCollectionView;
@property (nonatomic, weak) UITableView *addedTableView;


@end

@implementation PlanSectionTableViewCell

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)openCellWithTableView:(UITableView *)tableView forRowHeight:(CGFloat)rowHeight
{
    self.addedTableView = tableView;
    
    if([self.addedTableView isKindOfClass:[ContentTableView class]]){
        UINib *cellNib = [UINib nibWithNibName:@"ContentTableViewCell" bundle:nil];
        [self.addedTableView registerNib:cellNib forCellReuseIdentifier:@"ContentTableViewCell"];
        self.addedTableView.frame = CGRectMake(65, 90, 300, rowHeight);
    }else if([self.addedTableView isKindOfClass:[MultipleChoiceTableView class]]){
        UINib *cellNib = [UINib nibWithNibName:@"MutlipleChoiceTableViewCell" bundle:nil];
        [self.addedTableView registerNib:cellNib forCellReuseIdentifier:@"MultipleChoiceCell"];
        self.addedTableView.frame = CGRectMake(80, 90, 300, rowHeight);
    }else{
        UINib *cellNib = [UINib nibWithNibName:@"RecoveryTableViewCell" bundle:nil];
        [self.addedTableView registerNib:cellNib forCellReuseIdentifier:@"RecoveryTableViewCell"];
        self.addedTableView.frame = CGRectMake(65, 90, 300, rowHeight);
    }

    self.addedTableView.alpha = 0;

    [self.contentView addSubview:self.addedTableView];
    
    [UIView animateWithDuration:0.55 animations:^{
        self.addedTableView.alpha = 1;
        self.downArrow.alpha = 1;
        self.subtitleLabel.alpha = 1;
    }];
}



-(void)closeCellRemoveCollectionView:(void (^)())completion
{
    [UIView animateWithDuration:0.14 animations:^{
        self.addedTableView.alpha = 0;
        self.downArrow.alpha = 0;
        self.subtitleLabel.alpha = 0;
    }completion:^(BOOL finished) {
        [self.addedTableView removeFromSuperview];
        self.addedTableView = nil;
        if(completion)
            completion();
    }];
   
}

@end
