//
//  TextViewController.m
//  3D
//
//  Created by Chad Zeluff on 11/26/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()

@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *)visibleCells {
    return @[self.backView, self.textView];
}

@end
