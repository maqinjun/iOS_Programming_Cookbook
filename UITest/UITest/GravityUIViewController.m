//
//  GravityUIViewController.m
//  UITest
//
//  Created by maqj on 15/6/22.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "GravityUIViewController.h"

@implementation GravityUIViewController
{
    CGRect lastFrame;
}

-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *barStart = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(start:)];
    UIBarButtonItem *barReset = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(undo:)];
    self.navigationItem.rightBarButtonItems = @[barReset, barStart];
    
    self.squareView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.squareView.center = self.view.center;
    lastFrame = self.squareView.frame;
    self.squareView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.squareView];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}

-(void)start:(id)sender{
    UIGravityBehavior *behavior = [[UIGravityBehavior alloc] initWithItems:@[self.squareView]];
    
    [self.animator addBehavior:behavior];
}

-(void)undo:(id)sender{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.1];

    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.squareView.frame = lastFrame;

    [UIView commitAnimations];
}
@end
