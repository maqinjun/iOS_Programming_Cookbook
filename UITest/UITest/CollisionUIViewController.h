//
//  CollisionUIViewController.h
//  UITest
//
//  Created by maqj on 15/6/22.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollisionUIViewController : UIViewController
@property(nonatomic, strong) NSMutableArray *squareViews;
@property(nonatomic, strong) UIDynamicAnimator *animator;
@property(nonatomic) UISwitch *disapearSwitch;
@end
