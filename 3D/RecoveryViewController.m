//
//  RecoveryViewController.m
//  3D
//
//  Created by Chad Zeluff on 11/23/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "RecoveryViewController.h"
#import "RecoveryTableViewCell.h"

@interface RecoveryViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *colorsArray;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSArray *labelsArray;

@end

@implementation RecoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colorsArray = @[[UIColor whiteColor], [UIColor colorWithRed:17/255.0f green:37/255.0f blue:60/255.0f alpha:1], [UIColor colorWithRed:70/255.0f green:172/255.0f blue:194/255.0f alpha:1], [UIColor colorWithRed:209/255.0f green:122/255.0f blue:34/255.0f alpha:1]];
    
    self.titlesArray = @[@"Cervical Flexion", @"Corner Stretch", @"Segmental Flexion", @"Standing Back Bend"];
    self.labelsArray = @[@"• 3 sets", @"• 10 reps per set", @"• 2 sets per day"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.bounds.size.height / 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecoveryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recoveryCellIdentifier" forIndexPath:indexPath];
    
    cell.backgroundColor = self.colorsArray[indexPath.row];
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row+1];
    
    UIColor *textColor = (indexPath.row == 0) ? [UIColor colorWithRed:8/255.0f green:74/255.0f blue:133/255.0f alpha:1] : [UIColor whiteColor];
    
    cell.numberLabel.textColor = textColor;
    cell.recoveryTitle.textColor = textColor;
    cell.label1.textColor = textColor;
    cell.label2.textColor = textColor;
    cell.label3.textColor = textColor;
    
    cell.recoveryTitle.text = self.titlesArray[indexPath.row];
    cell.label1.text = self.labelsArray[0];
    cell.label2.text = self.labelsArray[1];
    cell.label3.text = self.labelsArray[2];

    
    return cell;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *)visibleCells {
    return [self.tableView visibleCells];
}

@end
