//
//  EncounterTableViewCell.h
//  3D
//
//  Created by Chad Zeluff on 11/26/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EncounterTableViewCell;

@protocol EncounterCellDelegate <NSObject>

- (void)closeCell:(EncounterTableViewCell *)cell;
- (void)clickedRow:(NSInteger)row forCell:(EncounterTableViewCell *)cell;

@end

@interface EncounterTableViewCell : UITableViewCell

@property (nonatomic, weak) id<EncounterCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *cardView;

- (void)openWithButtonTitles:(NSArray *)titles;

@end
