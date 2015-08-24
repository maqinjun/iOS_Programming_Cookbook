//
//  MultipleDynamicViewController.m
//  UITest
//
//  Created by maqj on 15/6/22.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "MultipleDynamicViewController.h"

@implementation MultipleDynamicViewController

-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    [self createGestureRecognizer];
    [self createSquareView];
    [self createAnchorView];
    [self createAnimatorAndBehavior];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)createGestureRecognizer{
    UIGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

-(void)handleTap:(UITapGestureRecognizer*)tapRecognizer{
    CGPoint tapPoint = [tapRecognizer locationInView:self.view];
    [self.attachmentBehavior setAnchorPoint:tapPoint];
    self.anchorView.center = tapPoint;
    
    CGPoint center = self.squareView.center;
    CGFloat deltaX = tapPoint.x - center.x;
    CGFloat deltaY = tapPoint.y - center.y;
    
    CGFloat angle = atan2(deltaY, deltaX);
    
    [self.pushBehavior setAngle:angle];
    
    CGFloat distance = sqrt(pow(tapPoint.x-center.x, 2.0)+pow(tapPoint.y-center.y, 2.0));
    
    [self.pushBehavior setMagnitude:distance/100.0f];
    
}

-(void)createSquareView{
    self.squareView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 80.0f, 80.0f)];
    self.squareView.center = self.view.center;
    self.squareView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.squareView];
    
    self.squareViewAnchorView = [[UIView alloc] initWithFrame:CGRectMake(60.0f, 0.0f, 20.0f, 20.0f)];
    self.squareViewAnchorView.backgroundColor = [UIColor brownColor];
    [self.squareView addSubview:self.squareViewAnchorView];
    
}

-(void)createAnchorView{
    self.anchorView = [[UIView alloc] initWithFrame:CGRectMake(120.0f, 120.0f, 20.0f, 20.0f)];
    self.anchorView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.anchorView];
}

-(void)createAnimatorAndBehavior{
    self.animaotr = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.squareView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    UIOffset offset;
    offset.horizontal = self.squareViewAnchorView.center.x;
    offset.vertical = self.squareViewAnchorView.center.y;
    
    self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.squareView offsetFromCenter:offset attachedToAnchor:self.anchorView.center];
    self.attachmentBehavior.damping = 10.0f;
    
    self.pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.squareView] mode:UIPushBehaviorModeContinuous];
    
    [self.animaotr addBehavior:collision];
    [self.animaotr addBehavior:self.pushBehavior];
    [self.animaotr addBehavior:self.attachmentBehavior];
}

@end
