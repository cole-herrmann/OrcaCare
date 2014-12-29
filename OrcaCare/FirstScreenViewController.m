//
//  FirstScreenViewController.m
//  Orca Care
//
//  Created by Cole Herrmann on 12/26/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "FirstScreenViewController.h"
#import <POP/POP.h>
#import <POP+MCAnimate/POP+MCAnimate.h>
#import "FadeTransitionAnimator.h"
#import "TimelineShellViewController.h"

//#import <MCShorthand.h>

@interface FirstScreenViewController () <UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (assign) BOOL loginMode;
@property (assign) BOOL signUpMode;
@property (weak, nonatomic) IBOutlet UIImageView *blueWhale;
@property (weak, nonatomic) IBOutlet UILabel *orcaCareLabel;
@property (weak, nonatomic) IBOutlet UIView *signUpView;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;

@property (weak, nonatomic) IBOutlet UITextField *signInEmail;
@property (weak, nonatomic) IBOutlet UITextField *signInPassword;

@property (weak, nonatomic) IBOutlet UITextField *signUpFullName;
@property (weak, nonatomic) IBOutlet UITextField *signUpEmail;
@property (weak, nonatomic) IBOutlet UITextField *signUpPassword;
@property (weak, nonatomic) IBOutlet UIButton *forgotPassword;

@end

@implementation FirstScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginView.alpha = 0;
    self.signUpView.alpha = 0;
    self.dismissButton.alpha = 0;
    
    [self makeGradientBackground];
}


-(void)makeGradientBackground
{
    UIColor *firstColor = [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1];
    UIColor *secondColor = [UIColor colorWithRed:0.031 green:0.290 blue:0.522 alpha:1];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = [NSArray arrayWithObjects: (id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    
    gradient.startPoint = CGPointMake(0.5, 0.1);
    gradient.endPoint = CGPointMake(0.5, 1.5);
    
    self.loginView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.85, 0.85);
    self.signUpView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.85, 0.85);

    gradient.frame = self.view.bounds;
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (IBAction)signIn:(id)sender {
    
    if(([sender isEqual:self.login] && !self.loginMode) || [sender isEqual:self.dismissButton]){
    
        CGFloat loginButtonTranslate = -(self.login.frame.origin.y - (CGRectGetMaxY(self.loginView.frame) + 15));
       
        self.loginView.layer.pop_springBounciness = 5;
        self.loginView.layer.pop_springSpeed = 15;
        self.loginView.layer.pop_spring.pop_scaleXY = (self.loginMode) ?  CGPointMake(0.85, 0.85) : CGPointMake(1, 1);
        
        self.loginView.pop_spring.alpha = (self.loginMode) ? 0 : 1;
        
        self.loginView.layer.pop_duration = 0;
        
        self.forgotPassword.pop_spring.alpha = (self.loginMode) ? 1 : 0;
        
        self.orcaCareLabel.pop_spring.alpha = (self.loginMode) ? 1 : 0;
        self.dismissButton.pop_spring.alpha = (self.loginMode) ? 0 : 1;
        
        self.blueWhale.layer.pop_spring.pop_translationY = (self.loginMode) ? 0 : -100;
        self.blueWhale.layer.pop_spring.pop_scaleXY = (self.loginMode) ?  CGPointMake(1, 1) : CGPointMake(0.6, 0.6);
        
        self.login.layer.pop_springBounciness = 3;
        self.login.layer.pop_springSpeed = 10;
        self.login.layer.pop_spring.pop_translationY = (self.loginMode) ? 0 : loginButtonTranslate;
        
        self.signUpButton.pop_spring.alpha = (self.loginMode) ? 1 : 0;
        
        if([sender isEqual:self.dismissButton]){
            [self.view endEditing:YES];
        }else{
            [self.signInEmail becomeFirstResponder];
           
        }
        
        self.loginMode = !self.loginMode;
    
    }else if([sender isEqual:self.login] && self.loginMode){
        //login logic
        [self pushToTimeline];
    }
    
}

- (IBAction)signUp:(id)sender {
    
    if(([sender isEqual:self.signUpButton] && !self.signUpMode) || [sender isEqual:self.dismissButton]){
    
        CGFloat signUpButtonTranslate = -(self.signUpButton.frame.origin.y - (CGRectGetMaxY(self.signUpView.frame) + 15));
        
        self.signUpView.layer.pop_springBounciness = 5;
        self.signUpView.layer.pop_springSpeed = 15;
        self.signUpView.layer.pop_spring.pop_scaleXY = (self.signUpMode) ?  CGPointMake(0.8, 0.8) : CGPointMake(1, 1);
        
        self.signUpView.pop_spring.alpha = (self.signUpMode) ? 0 : 1;
        self.signUpView.pop_duration = 0.2;

        self.forgotPassword.pop_spring.alpha = (self.signUpMode) ? 1 : 0;
        
        self.orcaCareLabel.pop_spring.alpha = (self.signUpMode) ? 1 : 0;
        
        self.dismissButton.pop_spring.alpha = (self.signUpMode) ? 0 : 1;
        
        self.blueWhale.layer.pop_spring.pop_translationY = (self.signUpMode) ? 0 : -100;
        self.blueWhale.layer.pop_spring.pop_scaleXY = (self.signUpMode) ?  CGPointMake(1, 1) : CGPointMake(0.6, 0.6);
        
        self.signUpButton.layer.pop_springBounciness = 3;
        self.signUpButton.layer.pop_springSpeed = 10;
        self.signUpButton.layer.pop_spring.pop_translationY = (self.signUpMode) ? 0 : signUpButtonTranslate;
        
        self.login.pop_spring.alpha = (self.signUpMode) ? 1 : 0;
        
        
        if([sender isEqual:self.dismissButton]){
            [self.view endEditing:YES];
        }else{
            [self.signUpFullName becomeFirstResponder];
        }
        
        self.signUpMode = !self.signUpMode;
        
    }else if([sender isEqual:self.signUpButton] && self.signUpMode){
        //login logic
        [self pushToTimeline];
    }

}

-(void)pushToTimeline
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"SecondDesign" bundle: nil];
    TimelineShellViewController *timelineVC = (TimelineShellViewController *)[storyBoard instantiateViewControllerWithIdentifier: @"TimelineShellVC"];
    timelineVC.transitioningDelegate = self;
    timelineVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:timelineVC animated:YES completion:nil];
}

- (IBAction)dismiss:(id)sender {
    if(self.loginMode){
        [self signIn:sender];
    }else if(self.signUpMode){
        [self signUp:sender];
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    
    FadeTransitionAnimator *animator = [FadeTransitionAnimator new];
    return animator;
}


@end
