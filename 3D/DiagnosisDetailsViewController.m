//
//  DiagnosisDetailsViewController.m
//  3D
//
//  Created by Chad Zeluff on 11/23/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "DiagnosisDetailsViewController.h"
#import "TableHeaderView.h"

static NSString *TableHeaderViewIdentifier = @"TableHeaderViewIdentifier";

@interface DiagnosisDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet UIImageView *diagnosisDetialsImageView;

@property (nonatomic, strong) NSArray *headerTitles;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *headerImages;

@end

@implementation DiagnosisDetailsViewController
/*
- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedImageView.alpha = 0;
    self.selectedImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissImage:)];
    
    [self.selectedImageView addGestureRecognizer:tap];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)showNormalRotatorCuff:(id)sender {
    
    [UIView animateWithDuration:0.4 animations:^{
        self.diagnosisDetialsImageView.alpha = 0;
        self.selectedImageView.image = [UIImage imageNamed:@"rotatorcuff"];
        self.selectedImageView.alpha = 1;
    }];
}

-(void)dismissImage:(id)sender
{
    [UIView animateWithDuration:0.4 animations:^{
        self.diagnosisDetialsImageView.alpha = 1;
        self.selectedImageView.alpha = 0;
    }];
}
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    self.titles = @[@[@"Normal Rotator Cuff", @"Abnormal Rotator Cuff", @"Rotator Cuff MRI"], @[@"Normal Rotator Cuff Scope", @"Torn Rotator Cuff Scope"], @[@"Overview", @"Symptoms", @"Diagnosis"]];
    self.headerTitles = @[@"Images", @"Videos", @"Text"];
    self.headerImages = @[[UIImage imageNamed:@"camera"], [UIImage imageNamed:@"video"], [UIImage imageNamed:@"text"]];
    
    UINib *sectionHeaderNib = [UINib nibWithNibName:@"TableHeader" bundle:nil];
    [self.tableView registerNib:sectionHeaderNib forHeaderFooterViewReuseIdentifier:TableHeaderViewIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titles[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *DiagnosisCellIdentifier = @"DiagnosisCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DiagnosisCellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.text = self.titles[indexPath.section][indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 56.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    TableHeaderView *tableHeaderView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:TableHeaderViewIdentifier];
    
    tableHeaderView.titleLabel.text = self.headerTitles[section];
    
    tableHeaderView.imageView.image = self.headerImages[section];
    
    return tableHeaderView;
}

@end
