//
//  PlanSectionsViewController.m
//  Orca Care
//
//  Created by Cole Herrmann on 12/17/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "PlanSectionsViewController.h"
#import "PlanSectionTableViewCell.h"

@interface PlanSectionsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PlanSectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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

@end
