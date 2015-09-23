//
//  EventViewController.m
//  UITest
//
//  Created by maqj on 15/9/19.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "EventViewController.h"
#import "EventUIView.h"

@interface EventViewController ()

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    EventUIView *view = [[EventUIView alloc] initWithFrame:CGRectMake(200.0f, 200.0f, 50.0f, 50.0f)];
    view.backgroundColor = [UIColor redColor];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [view addGestureRecognizer:tapGesture];
    
    [self.view addSubview:view];
}

- (void)handleTap:(UITapGestureRecognizer*)gesture{
    NSLog(@"%s", __FUNCTION__);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s \n %@", __FUNCTION__, [event allTouches]);
    
    [super touchesBegan:touches withEvent:event];
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
