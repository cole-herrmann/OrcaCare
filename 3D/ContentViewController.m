//
//  ContentViewController.m
//  Orca Care
//
//  Created by Cole Herrmann on 12/11/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "ContentViewController.h"
#import "ContentCollectionViewCell.h"
#import "TextViewController.h"

@interface ContentViewController () <UICollectionViewDelegate, UICollectionViewDataSource, URBMediaFocusViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *contentCollectionView;
@property (nonatomic, strong) NSArray *imageNames;
@property (nonatomic, strong) NSArray *cellLabels;
@property (nonatomic, strong) URBMediaFocusViewController *mediaVC;
@property (nonatomic, strong) NSDictionary *plistDictionary;


@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ConditionText" ofType:@"plist"];
    self.plistDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    UINib *cellNib = [UINib nibWithNibName:@"ContentCollectionViewCell" bundle:nil];
    [self.contentCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"CollectionCell"];
    self.contentCollectionView.alwaysBounceVertical = YES;
    
    self.imageNames = [[NSArray alloc]initWithObjects:@"spine", @"abnormal", @"normal", @"lumbarvidthumb", @"texticon", nil];
    self.cellLabels = [[NSArray alloc]initWithObjects:@"Spine Anatomy", @"Abnormal Disk", @"Normal Disk", @"Lumbar Disc Herniation Video", @"Diagnosis Overview", nil];


    // Do any additional setup after loading the view.
}

- (NSArray*)visibleCells
{
    NSMutableArray *array = [NSMutableArray array];
//    [array addObject:self.backView];
    NSInteger sections = [self.contentCollectionView numberOfSections];
    for(int i = 0; i < sections; i++) {
//        [array addObject:[self.contentCollectionView headerViewForSection:i]];
        NSInteger rows = [self.contentCollectionView numberOfItemsInSection:i];
        for(int j = 0; j < rows; j++) {
            ContentCollectionViewCell *cell = (ContentCollectionViewCell *)[self.contentCollectionView cellForItemAtIndexPath:[NSIndexPath
                                                                                                                               indexPathForRow:j
                                                                                                                               inSection:i]];
            if(cell != nil){
                [array addObject:cell];
            }
        }
    }
    
    return [self.contentCollectionView visibleCells];//array;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.imageNames count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    ContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    cell.thumbnailImageView.image = [UIImage imageNamed:self.imageNames[indexPath.row]];
    cell.contentLabel.text = self.cellLabels[indexPath.row];


    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.mediaVC = [[URBMediaFocusViewController alloc] init];
    
    if(indexPath.row == 3){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBackground" object:nil userInfo:@{ @"video" : @"lumbarvideo" }];

    }else if(indexPath.row == 4){

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        TextViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"TextVC"];
        vc.view.backgroundColor = self.view.backgroundColor;
        NSArray *titles = [self.plistDictionary objectForKey:@"titles"];
        NSArray *texts = [self.plistDictionary objectForKey:@"texts"];
        vc.titleLabel.text = titles[0];
        vc.textView.text = texts[0];
        
        [self.navigationController pushViewController:vc animated:YES];
    
    }else{
        
        [self.mediaVC showImage:[UIImage imageNamed:self.imageNames[indexPath.row]] fromView:[self.contentCollectionView cellForItemAtIndexPath:indexPath]];
    
    }
}

- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
