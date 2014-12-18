//
//  TimelineShellViewController.m
//  Orca Care
//
//  Created by Cole Herrmann on 12/17/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "TimelineShellViewController.h"

@interface TimelineShellViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, strong) UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation TimelineShellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.backImageView = [[UIImageView alloc] init];
//    self.backImageView.frame = self.containerView.frame;
////    self.backImageView.backgroundColor = [UIColor greenColor];
//    
//    self.containerView.hidden = YES;
//    
//    [self.containerView addSubview:self.backImageView];
//    
//    CGRect grabRect = self.containerView.frame;
//    [self makeGradientBackground];
//    
//    //for retina displays
//    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
//        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, [UIScreen mainScreen].scale);
//    } else {
//        UIGraphicsBeginImageContext(grabRect.size);
//    }
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextTranslateCTM(ctx, -grabRect.origin.x, -grabRect.origin.y);
//    [self.view.layer renderInContext:ctx];
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    self.backImageView.image = viewImage;
//    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
//    UIGraphicsEndImageContext();
//    
//    self.lineView.hidden = NO;
//    self.containerView.hidden = NO;
//    
//    [self.containerView sendSubviewToBack:self.backImageView];
    [self makeGradientBackground];
    

    
    
}

-(void) makeGradientBackground
{
    UIColor *firstColor = [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1];
    UIColor *secondColor = [UIColor colorWithRed:0.031 green:0.290 blue:0.522 alpha:1];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = [NSArray arrayWithObjects: (id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    
    gradient.startPoint = CGPointMake(0.5, 0.1);
    gradient.endPoint = CGPointMake(0.5, 1.5);
    
    
    gradient.frame = self.view.bounds;
    [self.view.layer insertSublayer:gradient atIndex:0];

}



@end
