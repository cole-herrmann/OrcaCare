//
//  RecoveryTableViewCell.h
//  Orca Care
//
//  Created by Chad Zeluff on 12/12/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecoveryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *recoveryTitle;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;

@end
