//
//  UIViewControllerFirstPage.m
//  UITest
//
//  Created by maqj on 15/6/22.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "UIViewControllerPage.h"

@implementation UIViewControllerPage
{
    BOOL transiting;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    label.adjustsFontSizeToFitWidth = YES;
    label.center = self.view.center;
    
    if (self.pageDetail) {
        label.text = [NSString stringWithFormat:@"%@:%ld",  self.pageDetail, (long)self.index];
    }
    
    [self.view addSubview:label];
}

-(void)transitingSet{
    
//    if (transiting) {
//        return;
//    }
//    transiting = YES;
//    [self transitionFromViewController:self toViewController:newVC duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//        
//    } completion:^(BOOL finished) {
//        
//        transiting = NO;
//    }];
}

//-(void)setPageDetail:(id)itemDetail{
//    if (itemDetail) {
//        self.pageDetail = itemDetail;
//    }
//}

@end
