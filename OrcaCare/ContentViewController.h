//
//  ContentViewController.h
//  Orca Care
//
//  Created by Cole Herrmann on 12/11/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <URBMediaFocusViewController/URBMediaFocusViewController.h>

@interface ContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic) BOOL isTreatment;

@end
