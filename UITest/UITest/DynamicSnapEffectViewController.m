//
//  DynamicSnapEffectViewController.m
//  UITest
//
//  Created by maqj on 15/6/22.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "DynamicSnapEffectViewController.h"

@implementation DynamicSnapEffectViewController
-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createSqureView];
    [self createAnimatorAndBehavior];
    [self createGestureRecognizer];
}

-(void)createGestureRecognizer{
    
//    UIGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    UIGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    self.squareView.userInteractionEnabled = YES;
    [self.squareView addGestureRecognizer:gestureRecognizer];
}

-(void)handleTap:(UITapGestureRecognizer*)tapGesture{
    CGPoint tapPoint = [tapGesture locationInView:self.view];
    
    if (self.snapBehavior != nil) {
        [self.animator removeBehavior:self.snapBehavior];
    }
    
    self.snapBehavior = [[UISnapBehavior alloc] initWithItem:self.squareView snapToPoint:tapPoint];
    self.snapBehavior.damping = 0.2f;
    
    [self.animator addBehavior:self.snapBehavior];
}

-(void)createSqureView{
    self.squareView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80.0f, 80.0f)];
    self.squareView.center = self.view.center;
    self.squareView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.squareView];
}

-(void)createAnimatorAndBehavior{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.squareView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    self.snapBehavior = [[UISnapBehavior alloc] initWithItem:self.squareView snapToPoint:self.squareView.center];
    self.snapBehavior.damping = 0.5f;
    [self.animator addBehavior:collision];
    [self.animator addBehavior:self.snapBehavior];
}

@end
