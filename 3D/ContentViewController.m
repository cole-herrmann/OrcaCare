//
//  ContentViewController.m
//  Orca Care
//
//  Created by Cole Herrmann on 12/11/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "ContentViewController.h"
#import "ContentCollectionViewCell.h"

@interface ContentViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *contentCollectionView;
@property (nonatomic, strong) NSArray *imageNames;
@property (nonatomic, strong) NSArray *cellLabels;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"ContentCollectionViewCell" bundle:nil];
    [self.contentCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"CollectionCell"];
    self.contentCollectionView.alwaysBounceVertical = YES;
    
    self.imageNames = [[NSArray alloc]initWithObjects:@"spine", @"abnormal", @"normal", @"spinearthritis", @"spineside", @"texticon", nil];
    self.cellLabels = [[NSArray alloc]initWithObjects:@"Spine Anatomy", @"Abnormal Disk", @"Normal Disk", @"Arthritic Spine", @"Spine Cross Section", @"Diagnosis Description", nil];


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
    
    return array;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.imageNames count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    ContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    cell.thumbnailImageView.image = [UIImage imageNamed:self.imageNames[indexPath.row]];
    cell.contentLabel.text = self.cellLabels[indexPath.row];


    return cell;
}

- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
