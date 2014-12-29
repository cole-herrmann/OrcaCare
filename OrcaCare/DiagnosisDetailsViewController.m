//
//  DiagnosisDetailsViewController.m
//  3D
//
//  Created by Chad Zeluff on 11/23/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "DiagnosisDetailsViewController.h"
#import "TableHeaderView.h"
#import "TextViewController.h"

static NSString *TableHeaderViewIdentifier = @"TableHeaderViewIdentifier";

@interface DiagnosisDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet UIImageView *diagnosisDetialsImageView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSDictionary *plistDictionary;

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
    self.tableView.backgroundColor = [UIColor clearColor];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ConditionText" ofType:@"plist"];
    self.plistDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    self.titles = @[@[@"Normal Disc", @"Abnormal Disc"], @[@"Lumbar Disc Herniation Explained"], [self.plistDictionary objectForKey:@"titles"]];
    self.headerTitles = @[@"Images", @"Videos", @"Text"];
    self.headerImages = @[[UIImage imageNamed:@"camera"], [UIImage imageNamed:@"video"], [UIImage imageNamed:@"text"]];
    
    UINib *sectionHeaderNib = [UINib nibWithNibName:@"TableHeader" bundle:nil];
    [self.tableView registerNib:sectionHeaderNib forHeaderFooterViewReuseIdentifier:TableHeaderViewIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray*)visibleCells
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:self.backView];
    NSInteger sections = [self.tableView numberOfSections];
    for(int i = 0; i < sections; i++) {
        [array addObject:[self.tableView headerViewForSection:i]];
        NSInteger rows = [self.tableView numberOfRowsInSection:i];
        for(int j = 0; j < rows; j++) {
            [array addObject:[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]]];
        }
    }

    return array;
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    self.navigationController.navigationBarHidden = NO;
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    
//    self.navigationController.navigationBarHidden = YES;
//}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSString *notifcationKey;
    NSString *notifcationValue;
    
    if(section == 0) {

        //image
        if (indexPath.row == 0) {
            notifcationKey = @"image";
            notifcationValue = @"normal";
        } else if(indexPath.row == 1){
            notifcationKey = @"image";
            notifcationValue = @"abnormal";
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBackground" object:nil userInfo:@{ notifcationKey : notifcationValue }];

        
    } else if(section == 1) {
        
        //video
        if(indexPath.row == 0){
            notifcationKey = @"video";
            notifcationValue = @"lumbarvideo";
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBackground" object:nil userInfo:@{ notifcationKey : notifcationValue }];
        
    } else if (section == 2) {
        [self performSegueWithIdentifier:@"textSegue" sender:[NSNumber numberWithInteger:indexPath.row]];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"textSegue"]) {
        TextViewController *vc = [segue destinationViewController];
        vc.view.backgroundColor = self.view.backgroundColor;
        int row = [sender intValue];
        NSArray *titles = [self.plistDictionary objectForKey:@"titles"];
        NSArray *texts = [self.plistDictionary objectForKey:@"texts"];
        vc.titleLabel.text = titles[row];
        vc.textView.text = texts[row];
    }
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
