//
//  DiagnosisDetailsViewController.m
//  3D
//
//  Created by Chad Zeluff on 11/23/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "DiagnosisDetailsViewController.h"

@interface DiagnosisDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet UIImageView *diagnosisDetialsImageView;

@end

@implementation DiagnosisDetailsViewController

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

@end
