//
//  ManView.m
//  3D
//
//  Created by Cole Herrmann on 11/20/14.
//  Copyright (c) 2014 Cole Herrmann. All rights reserved.
//

#import "ManView.h"

@interface ManView()

@property (nonatomic, strong) SCNNode *cameraNode;

@end

@implementation ManView

-(void)awakeFromNib
{
    SCNScene *scene = [SCNScene scene];
    self.scene = scene;
//    self.allowsCameraControl = YES;
    SCNScene *fullBody = [SCNScene sceneNamed:@"fullbody.dae"];
    SCNNode *bodyNode = [fullBody.rootNode childNodeWithName:@"body" recursively:YES];
    [scene.rootNode addChildNode:bodyNode];
//    NSArray *childNodes = self.scene.rootNode.childNodes;
    
    SCNNode *cameraNode = [SCNNode node];
    self.cameraNode = cameraNode;
    cameraNode.camera = [SCNCamera camera];
    cameraNode.position = SCNVector3Make(0, 10, 30);
    [scene.rootNode addChildNode:cameraNode];
    
    

}

-(void)animateToFeet
{

//    CABasicAnimation *animationToFeet = [CABasicAnimation animationWithKeyPath:@"position"];
//    animationToFeet.toValue = [NSValue valueWithSCNVector3:SCNVector3Make(0, 2, 12)];
//    animationToFeet.duration = .75;
//    animationToFeet.removedOnCompletion = NO;
//    animationToFeet.fillMode = kCAFillModeForwards;
//    [self.cameraNode addAnimation:animationToFeet forKey:@"feetAnimation"];
//    self.cameraNode.position = SCNVector3Make(0, 2, 25);
    
    [SCNTransaction begin];
    [SCNTransaction setAnimationDuration: 0.7];
    [SCNTransaction setCompletionBlock:^{
        [SCNTransaction begin];
        [SCNTransaction setAnimationDuration: 0.7];
        self.cameraNode.position = SCNVector3Make(4, 2, 9);
        [SCNTransaction commit];
    }];
    SCNNode *tarsalNode = [self.scene.rootNode childNodeWithName:@"Metatarsal_05" recursively:YES];
    SCNLookAtConstraint *footConstraint = [SCNLookAtConstraint lookAtConstraintWithTarget:tarsalNode];
    self.cameraNode.constraints = @[footConstraint];
    [SCNTransaction commit];
    

}

-(void)removeFeetAnimation
{
    
    [SCNTransaction begin];
    [SCNTransaction setAnimationDuration: 0.7];
    
    self.cameraNode.constraints = nil;
    self.cameraNode.position = SCNVector3Make(0, 10, 30);
    [SCNTransaction commit];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touched");
}

@end
