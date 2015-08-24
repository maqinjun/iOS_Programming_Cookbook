//
//  AutoLayoutViewController.m
//  UITest
//
//  Created by maqj on 15/6/25.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "AutoLayoutViewController.h"

@interface AutoLayoutViewController ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation AutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.testCenterLabel = [[UILabel alloc] init];
    self.testCenterLabel.text = @"I'm center Label.";
    self.testCenterLabel.textColor = [UIColor blackColor];
    self.testCenterLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.centerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.button setTitle:@"Buton" forState:UIControlStateNormal];
    
    UIView *superView = self.centerLabel.superview;
    
    [superView addSubview:self.button];
    [superView addSubview:self.testCenterLabel];
    
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.testCenterLabel
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:superView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0f
                                                                          constant:0.0f];
    
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.testCenterLabel
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:superView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0f
                                                                          constant:0.0f];
    
    [superView addConstraints:@[centerXConstraint, centerYConstraint]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
