//
//  PushBehaviorUIViewController.m
//  UITest
//
//  Created by maqj on 15/6/22.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "PushBehaviorUIViewController.h"

@implementation PushBehaviorUIViewController
-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *barStart = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(start:)];
    self.navigationItem.rightBarButtonItems = @[barStart];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self createGestureRecgnizer];
    [self createSquareView];
    [self createAnimaterAndBehavior];
}

-(void)createAnimaterAndBehavior{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UICollisionBehavior *collison = [[UICollisionBehavior alloc] initWithItems:@[self.squareView]];
    collison.translatesReferenceBoundsIntoBoundary = YES;
    
    self.pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.squareView] mode:UIPushBehaviorModeContinuous];
    
    [self.animator addBehavior:collison];
    [self.animator addBehavior:self.pushBehavior];
}

-(void)createSquareView{
    self.squareView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 80.0f, 80.0f)];
    self.squareView.center = self.view.center;
    self.squareView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.squareView];
}

-(void)start:(id)sender{
    [self.pushBehavior setAngle:130.0f];
    [self.pushBehavior setMagnitude:10.0f];
}

-(void)handleTap:(UITapGestureRecognizer*)tapGesture{
    
    CGPoint tapPoint = [tapGesture locationInView:self.view];
    CGPoint sequareViewCenterPoint = self.squareView.center;
    
    CGFloat deltaX = tapPoint.x - sequareViewCenterPoint.x;
    CGFloat deltaY = tapPoint.y - sequareViewCenterPoint.y;
    CGFloat angle = atan2(deltaY, deltaX);
    
    [self.pushBehavior setAngle:angle];
    
    CGFloat distanceBetweenPoint = sqrt(pow(tapPoint.x-sequareViewCenterPoint.x, 2.0) + pow(tapPoint.y-sequareViewCenterPoint.y, 2.0));
    
    [self.pushBehavior setMagnitude:distanceBetweenPoint/300.0f];
}

-(void)createGestureRecgnizer{
    UIGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}


@end
