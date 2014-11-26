//
//  ShellViewController.m
//  3D
//
//  Created by Chad Zeluff on 11/24/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "ShellViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ShellViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, weak) MPMoviePlayerViewController *playerVC;
@property (nonatomic, strong) UITapGestureRecognizer *imageViewTap;


@end

@implementation ShellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBackground:) name:@"changeBackground" object:nil];

}

- (void)changeBackground:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    [self fadeContainer:NO];
    
    NSString *imageName = userInfo[@"image"];
    NSString *videoName = userInfo[@"video"];
    if(imageName) {
        UIImage *newImage = [UIImage imageNamed:imageName];
        if(newImage) {
           
            self.backgroundImageView.image = newImage;
            self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
//            [self.view bringSubviewToFront:self.backgroundImageView];
            
            CATransition *transition = [CATransition animation];
            transition.duration = 0.4f;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            transition.type = kCATransitionFade;
            [self.backgroundImageView.layer addAnimation:transition forKey:nil];
            
            self.backgroundImageView.userInteractionEnabled = YES;
            self.imageViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissImage)];
            [self.backgroundImageView addGestureRecognizer:self.imageViewTap];
            
            
        }
    } else if (videoName) {
        NSURL *urlString = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:videoName ofType:@"mp4"]];
        
        MPMoviePlayerViewController *playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:urlString];
        playerVC.view.alpha = 0.0;
        [self addChildViewController:playerVC];
        [self.view insertSubview:playerVC.view aboveSubview:self.backgroundImageView];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            playerVC.view.alpha = 1.0;
        } completion:nil];
        self.playerVC = playerVC;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(movieDone:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];
    }
}

-(void)fadeContainer:(BOOL)on
{
    [UIView animateWithDuration:0.4 animations:^{
        self.containerView.alpha = (on) ? 1 : 0;
    }];
}

-(void)movieDone:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];

    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.playerVC.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self fadeContainer:YES];
    }];

    
}

-(void)dismissImage
{

    [self fadeContainer:YES];
    
    [self.backgroundImageView removeGestureRecognizer:self.imageViewTap];
    
    self.backgroundImageView.image = [UIImage imageNamed:@"spine"];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type = kCATransitionFade;
    [self.backgroundImageView.layer addAnimation:transition forKey:nil];
    
    [self fadeContainer:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
