//
//  FTCIView.m
//  UITest
//
//  Created by maqj on 15/7/16.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "FTCIView.h"

@implementation FTCIView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIColor *color = [UIColor colorWithRed:255.0f green:0.1f blue:205.0f alpha:1.0f];
    [color set];
    
    UIFont *font = [UIFont fontWithName:@"SinhalaSangamMN-Bold" size:24.0f];

    NSString *testStr = @"Some String.";
    
    [testStr drawAtPoint:CGPointMake(20.0f, 70.0f) withAttributes:@{
                                                                    NSFontAttributeName: font
                                                                    }];
    //--------
    
    UIFont *helveticaBold = [UIFont boldSystemFontOfSize:30.0f];
    
    NSString *helveticaStr = @"I Learn Realy Fast.";
    
    [helveticaStr drawWithRect:CGRectMake(200.0f, 70.0f, 100.0f, 200.0f)
                       options:NSStringDrawingUsesLineFragmentOrigin
                    attributes:@{NSFontAttributeName: helveticaBold}
                       context:nil];
    
//    [helveticaStr drawInRect:CGRectMake(200.0f, 70.0f, 100.0f, 200.0f) withAttributes:@{
//                                                                                        NSFontAttributeName: helveticaBold
//                                                                                        }];
    
    //--------
    
    UIImage *image = [UIImage imageNamed:@"PinchGestureImage"];
    [image drawInRect:CGRectMake(20.0f, 100.0f, 150.0f, 220.0f)];
}


@end
