//
//  MultipleChoiceTableViewCell.h
//  Orca Care
//
//  Created by Cole Herrmann on 12/22/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentTableViewCell : UITableViewCell

@property (nonatomic, weak, readonly) UIImageView *thumbnailImageView;
@property (nonatomic, weak, readonly) UILabel *title;

@end
