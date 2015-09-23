//
//  EventUIView.m
//  UITest
//
//  Created by maqj on 15/9/19.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "EventUIView.h"

@implementation EventUIView


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s \n %@", __FUNCTION__, [event allTouches]);
    
    [super touchesBegan:touches withEvent:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
