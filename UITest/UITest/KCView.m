//
//  KCView.m
//  UITest
//
//  Created by maqj on 1/10/15.
//  Copyright © 2015 maqj. All rights reserved.
//

#import "KCView.h"
#import "KCLayer.h"

@implementation KCView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        KCLayer *layer = [[KCLayer alloc] init];
        layer.bounds = CGRectMake(0, 0, 185, 185);
        layer.position = CGPointMake(100, 184);
        layer.backgroundColor = [UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
        
        [layer setNeedsDisplay];
        
        [self.layer addSublayer:layer];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
