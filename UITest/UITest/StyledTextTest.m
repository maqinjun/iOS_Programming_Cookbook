//
//  StyledTextTest.m
//  UITest
//
//  Created by maqj on 15/6/21.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "StyledTextTest.h"

@implementation StyledTextTest
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Styled Texts";
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    lable.backgroundColor = [UIColor clearColor];
//    [lable sizeToFit];
    lable.center = self.view.center;
    lable.attributedText = [self attributedText];
//    lable.text = @"fuck you";
//    lable.textColor = [UIColor blackColor];
    [self.view addSubview:lable];
}

-(NSAttributedString*)attributedText{
    
    NSString *str = @"My Baby";
    
    NSMutableAttributedString *attribuedStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSDictionary *attribuedFirstWord = @{
                                         NSFontAttributeName:[UIFont boldSystemFontOfSize:60.0f],
                                         NSForegroundColorAttributeName: [UIColor blackColor],
                                         NSBackgroundColorAttributeName: [UIColor redColor]
                                         };
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor darkGrayColor];
    shadow.shadowOffset = CGSizeMake(1.0f , 1.0f);
    shadow.shadowBlurRadius = 10.0f;
    
    NSDictionary *attribuedSecondWord = @{
                                          NSFontAttributeName: [UIFont italicSystemFontOfSize:40.0f],
                                          NSForegroundColorAttributeName: [UIColor redColor],
                                          NSBackgroundColorAttributeName: [UIColor clearColor],
                                          NSShadowAttributeName: shadow
                                          };
    
    [attribuedStr setAttributes:attribuedFirstWord range:[str rangeOfString:@"My"]];
    [attribuedStr setAttributes:attribuedSecondWord range:[str rangeOfString:@"Baby"]];

    return attribuedStr;
}
@end
