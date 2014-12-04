//
//  CircleTransitionAnimator.swift
//  CircleTransition
//
//  Created by Chad Zeluff on 12/2/14.
//  Copyright (c) 2014 Rounak Jain. All rights reserved.
//

import UIKit

class CircleTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    weak var transitionContext: UIViewControllerContextTransitioning?
    weak var animationButton: UIButton!
    var presenting:Bool!
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        var containerView = transitionContext.containerView()
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var button = self.animationButton
        
        containerView.addSubview(toViewController.view)
        var circleMaskPathInitial = UIBezierPath(ovalInRect: button.frame)
        var extremePoint = CGPoint(x: button.center.x - 0, y: button.center.y + CGRectGetHeight(toViewController.view.bounds))
        var radius = sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y))
        var circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(button.frame, -radius, -radius))
        
        var maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.CGPath
        toViewController.view.layer.mask = maskLayer
        
        var maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
        maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
        maskLayerAnimation.duration = self.transitionDuration(transitionContext)
        maskLayerAnimation.delegate = self
        maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.8
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        self.transitionContext!.viewControllerForKey(UITransitionContextToViewControllerKey)?.view.layer.mask = nil
        self.transitionContext!.completeTransition(!self.transitionContext!.transitionWasCancelled())
    }
}
