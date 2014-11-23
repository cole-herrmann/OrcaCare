//
//  ViewController.m
//  3D
//
//  Created by Cole Herrmann on 11/19/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "CardViewController.h"
#import <SceneKit/SceneKit.h>
#import "ManView.h"
#import "PlanShellViewController.h"

@interface CardViewController () <PlanShellDelegate>
@property (weak, nonatomic) IBOutlet ManView *sceneView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *reverse;
@property (weak, nonatomic) IBOutlet UIButton *animate;

@end

@implementation CardViewController

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

- (IBAction)cardClicked:(id)sender {
    UIStoryboard *stb = self.storyboard;
    PlanShellViewController *shell = [stb instantiateViewControllerWithIdentifier:@"shell"];
    shell.delegate = self;
    
    UIViewController *pg1 = [stb instantiateViewControllerWithIdentifier:@"diagnosis"];
    UIViewController *pg2 = [stb instantiateViewControllerWithIdentifier:@"treatment"];
    UIViewController *pg3 = [stb instantiateViewControllerWithIdentifier:@"recovery"];
    UIViewController *pg4 = [stb instantiateViewControllerWithIdentifier:@"mycontent"];
    
    [shell addViewController:pg1];
    [shell addViewController:pg2];
    [shell addViewController:pg3];
    [shell addViewController:pg4];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:shell];
    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:YES completion:nil];

}

- (void)closePressed:(PlanShellViewController *)vc {
    [vc dismissViewControllerAnimated:YES completion:nil];
}

@end
