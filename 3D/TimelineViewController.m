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
@property (weak, nonatomic) IBOutlet UIView *headerView;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *firstColor = [UIColor whiteColor];
    UIColor *secondColor = [UIColor colorWithWhite:1 alpha:.7];
//    self.headerView.backgroundColor = [UIColor whiteColor];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = [NSArray arrayWithObjects: (id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    
    gradient.frame = self.headerView.bounds;
    gradient.startPoint = CGPointMake(0.5, 0.75);
    gradient.endPoint = CGPointMake(0.5, 1.1);
    
    [self.headerView.layer insertSublayer:gradient atIndex:0];

    self.tableView.contentInset = UIEdgeInsetsMake(self.headerView.frame.size.height, 0, 0, 0);
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

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
