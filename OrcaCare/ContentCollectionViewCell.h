//
//  ContentCollectionViewCell.h
//  Orca Care
//
//  Created by Cole Herrmann on 12/11/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentCollectionViewCell : UICollectionViewCell

@property (weak, readonly, nonatomic) UIImageView *thumbnailImageView;
@property (weak, readonly, nonatomic) UILabel *contentLabel;

@end
