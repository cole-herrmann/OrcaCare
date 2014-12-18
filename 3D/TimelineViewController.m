//
//  TimelineViewController.m
//  Orca Care
//
//  Created by Cole Herrmann on 12/17/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "TimelineViewController.h"
#import "TimelineTableViewCell.h"


@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIdentifier = @"TimelineCell";
    TimelineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[TimelineTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
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
    }else  if(indexPath.row == 3){
        
        cell.doctorPicture.image = [UIImage imageNamed:@"docpic"];
        cell.doctorLabel.text = @"Dr. Chad Zeluff";
        cell.dateLabel.text = @"10 • 22 • 2014";
        
    }else if(indexPath.row == 4){
        
        cell.doctorPicture.image = [UIImage imageNamed:@"drli"];
        cell.doctorLabel.text = @"Dr. Li Hashimoto";
        cell.dateLabel.text = @"7 • 12 • 2013";
        
    }else if(indexPath.row == 5){
        
        cell.doctorPicture.image = [UIImage imageNamed:@"mark"];
        cell.doctorLabel.text = @"Dr. Mark Johnson";
        cell.dateLabel.text = @"4 • 8 • 2011";
    }

    
    return cell;
}
@end
