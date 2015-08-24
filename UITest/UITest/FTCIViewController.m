//
//  FTCIViewController.m
//  UITest
//
//  Created by maqj on 15/7/16.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "FTCIViewController.h"

@interface FTCIViewController ()

@end

@implementation FTCIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self enumerateFonts];
    
    [self customButtonWithResizableImage];
}

- (void)customButtonWithResizableImage{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setFrame:CGRectMake(20.0f, 400.0f, 150.0f, 50.0f)];
    [button setTitle:@"Stretched Image on Button" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIImage *image = [UIImage imageNamed:@"PinchGestureImage"];
    
    UIEdgeInsets inserts;
    inserts.left = 14.0f;
    inserts.top = 0.0f;
    inserts.right = 14.0f;
    inserts.bottom = 0.0f;
    
    image = [image resizableImageWithCapInsets:inserts];
    
    [button setBackgroundImage:image forState:UIControlStateNormal];

    [self.view addSubview:button];
}

- (void)enumerateFonts{
    for (NSString *familyName in [UIFont familyNames]) {
        NSLog(@"Font family = %@", familyName);
        
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"\t --> %@", fontName);
        }
    }
    
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
