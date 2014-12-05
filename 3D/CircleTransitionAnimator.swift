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
    var presenting: Bool
    
    override init() {
        presenting = true
        super.init()
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        var containerView = transitionContext.containerView()
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var button = self.animationButton
        
        var vc = presenting ? toViewController : fromViewController
        
        containerView.addSubview(vc.view)
        var inset = button.frame.size.width / 2
        var circleMaskPathInitial = UIBezierPath(ovalInRect: CGRectInset(button.frame, inset, inset))
        var extremePoint = CGPoint(x: button.center.x - 0, y: CGRectGetHeight(toViewController.view.bounds))
        var radius = sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y))
        var circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(button.frame, -radius, -radius))
        
        if(!presenting) {
            var temp = circleMaskPathInitial
            circleMaskPathInitial = circleMaskPathFinal
            circleMaskPathFinal = temp
        }
        
        var maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.CGPath
        vc.view.layer.mask = maskLayer
        
        var maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
        maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
        maskLayerAnimation.duration = self.transitionDuration(transitionContext)
        maskLayerAnimation.delegate = self
        
        var easing = presenting ? kCAMediaTimingFunctionEaseIn : kCAMediaTimingFunctionEaseOut
        maskLayerAnimation.timingFunction = CAMediaTimingFunction(name: easing)
        maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        self.transitionContext!.viewControllerForKey(UITransitionContextToViewControllerKey)?.view.layer.mask = nil
        self.transitionContext!.completeTransition(!self.transitionContext!.transitionWasCancelled())
    }
}
