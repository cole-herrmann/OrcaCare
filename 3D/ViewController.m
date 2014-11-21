//
//  ViewController.m
//  3D
//
//  Created by Cole Herrmann on 11/19/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>
#import "ManView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ManView *sceneView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *reverse;
@property (weak, nonatomic) IBOutlet UIButton *animate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reverse.alpha = 0;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)animate:(id)sender {
    
    [UIView animateWithDuration:0.7 animations:^{
        self.scrollView.alpha = 1;
        self.animate.alpha = 0;
    }];
    
    [UIView animateWithDuration:1.5 animations:^{
        self.reverse.alpha = 1;
    }];
    
    [self.sceneView animateToFeet];
}
- (IBAction)reverse:(id)sender {
    [UIView animateWithDuration:0.7 animations:^{
        self.scrollView.alpha = 0;
        self.reverse.alpha = 0;
    }];
    
    [UIView animateWithDuration:1.5 animations:^{
        self.animate.alpha = 1;
    }];
    
    [self.sceneView removeFeetAnimation];
}

@end
