//
//  AssigningCharacteristicViewController.m
//  UITest
//
//  Created by maqj on 15/6/22.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "AssigningCharacteristicViewController.h"

@implementation AssigningCharacteristicViewController

-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *barStart = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(start:)];
    
    self.navigationItem.rightBarButtonItems = @[barStart];
    
}

-(void)start:(id)sender{
    
    UIView *topView = [self viewWithCenter:CGPointMake(100.0f, 0.0f) backgroundColor:[UIColor redColor]];
    UIView *bottomView = [self viewWithCenter:CGPointMake(100.0f, 130.0f) backgroundColor:[UIColor blueColor]];
    UIView *middleView = [self viewWithCenter:CGPointMake(100.0f, 65.0f) backgroundColor:[UIColor greenColor]];
    UIView *noMoveView = [self viewWithCenter:CGPointMake(100.0f, 195.0f) backgroundColor:[UIColor grayColor]];
    
    [self.view addSubview:middleView];
    [self.view addSubview:topView];
    [self.view addSubview:bottomView];
    [self.view addSubview:noMoveView];

    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[topView, bottomView, middleView, noMoveView]];
    [self.animator addBehavior:gravityBehavior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[topView, bottomView, middleView, noMoveView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collisionBehavior];
    
    UIDynamicItemBehavior *moreElasticItem = [[UIDynamicItemBehavior alloc] initWithItems:@[bottomView]];
    moreElasticItem.elasticity = 1.5f;
    moreElasticItem.friction = 10.0f;
    moreElasticItem.resistance = 0.2f;
    
    UIDynamicItemBehavior *lessElasticItem = [[UIDynamicItemBehavior alloc] initWithItems:@[topView, middleView]];
    lessElasticItem.elasticity = 1.2f;
    
    
    [self.animator addBehavior:moreElasticItem];
    [self.animator addBehavior:lessElasticItem];

}

-(UIView*)viewWithCenter:(CGPoint)center backgroundColor:(UIColor*)color{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, 50.0f)];
    view.center = center;
    view.backgroundColor = color;
    return view;
}

@end
