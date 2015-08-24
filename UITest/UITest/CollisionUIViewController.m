//
//  CollisionUIViewController.m
//  UITest
//
//  Created by maqj on 15/6/22.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "CollisionUIViewController.h"

@interface CollisionUIViewController ()<UICollisionBehaviorDelegate>

@end

NSString *const kIdentifier = @"bootomBounday";

@implementation CollisionUIViewController
{
    NSMutableArray *squareFrames;
    UIBarButtonItem *barStart;
    UIBarButtonItem *barUndo;
}


-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    
    barStart = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(start:)];
    barUndo = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(undo:)];
    barUndo.enabled = NO;
    self.disapearSwitch = [[UISwitch alloc] init];
    
    self.navigationItem.rightBarButtonItems = @[barStart, barUndo];
    self.navigationItem.titleView = self.disapearSwitch;
    
    [self initSquareViews];
}

-(void)initSquareViews{
    self.squareViews = [NSMutableArray array];
    squareFrames = [NSMutableArray array];
    
    int colume = 3;
    
    NSArray *colors = @[[UIColor redColor], [UIColor greenColor], [UIColor grayColor], [UIColor blueColor]];
    
    CGPoint center = self.view.center;

    CGFloat lastY = center.y;
    CGSize size = CGSizeMake(50.0f, 50.0f);
    center.x = 80.0f;
    
    for (int j = 0; j < colume; j++) {
        for (int i = 0; i < colors.count; i++) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
            view.center = center;
            view.backgroundColor = colors[i];
            center.y += size.height + 10.0f;
            
            UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(undo:)];
            [view addGestureRecognizer:gesture];
            
            [squareFrames addObject:[NSValue valueWithCGRect:view.frame]];
            
            [self.squareViews addObject:view];
            
            [self.view addSubview:view];
        }
        center.x += size.width + 20.0f;
        center.y = lastY;
    }
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}

-(void)start:(id)sender{
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:self.squareViews];
//    gravityBehavior.angle = 130.0f;
//    gravityBehavior.magnitude = 2.0f;
    gravityBehavior.gravityDirection = CGVectorMake(-10.0f, -5.0f);
    [self.animator addBehavior:gravityBehavior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:self.squareViews];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    //UICollisionBehaviorModeEverything
    collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;
    collisionBehavior.collisionDelegate = self;
    
//    [collisionBehavior addBoundaryWithIdentifier:kIdentifier fromPoint:CGPointMake(0.0f, self.view.bounds.size.height-100.0f) toPoint:CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height-100.0f)];
    [collisionBehavior addBoundaryWithIdentifier:kIdentifier fromPoint:CGPointMake(0.0f, 20.0f+self.navigationController.navigationBar.frame.size.height) toPoint:CGPointMake(self.view.bounds.size.width, 20.0f+self.navigationController.navigationBar.frame.size.height)];

//    [collisionBehavior addBoundaryWithIdentifier:<#(id<NSCopying>)#> forPath:<#(UIBezierPath *)#>]
    
    [self.animator addBehavior:collisionBehavior];
    
    barStart.enabled = NO;
    barUndo.enabled = YES;
}

-(void)undo:(id)sender{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    
    for(int i = 0; i < self.squareViews.count; i++){
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelay:0.1];

        UIView *view = self.squareViews[i];
        CGRect rect = [squareFrames[i] CGRectValue];
        view.frame = rect;
        [UIView commitAnimations];

    }
    
    barStart.enabled = YES;
    barUndo.enabled = NO;
}

- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item1 withItem:(id <UIDynamicItem>)item2 atPoint:(CGPoint)p{
    NSLog(@"item1: %@, item2: %@, p(%f, %f)", item1, item2, p.x, p.y);
}
- (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id <UIDynamicItem>)item1 withItem:(id <UIDynamicItem>)item2{
    NSLog(@"item1: %@, item2: %@", item1, item2);
}

// The identifier of a boundary created with translatesReferenceBoundsIntoBoundary or setTranslatesReferenceBoundsIntoBoundaryWithInsets is nil
- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(id <NSCopying>)identifier atPoint:(CGPoint)p{
    NSLog(@"item: %@, identifier: %@, p(%f, %f)", item, identifier, p.x, p.y);
    
    if (!self.disapearSwitch.on) {
        return;
    }
    
    NSString *curIdentifier = (NSString*)identifier;
    
    if ([curIdentifier isEqualToString:kIdentifier]) {
        [UIView animateWithDuration:1.0f animations:^{
            UIView *view = (UIView*)item;
            view.backgroundColor = [UIColor magentaColor];
            view.alpha = 0.0f;
            view.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
        } completion:^(BOOL finished) {
            UIView *view = (UIView*)item;
            [behavior removeItem:view];
            [view removeFromSuperview];
            
            barUndo.enabled = NO;
            barStart.enabled = NO;
        }];
    }
}
- (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(id <NSCopying>)identifier{
    NSLog(@"item: %@, identifier: %@", item, identifier);
}


@end
