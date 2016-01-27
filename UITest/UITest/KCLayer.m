//
//  KCLayer.m
//  UITest
//
//  Created by maqj on 1/10/15.
//  Copyright © 2015 maqj. All rights reserved.
//

#import "KCLayer.h"

@implementation KCLayer

- (void)drawInContext:(CGContextRef)ctx{
    CGContextSetRGBFillColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
    CGContextSetRGBStrokeColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
    
    CGContextMoveToPoint(ctx, 94.5, 33.5);
    
    CGContextAddLineToPoint(ctx, 104.02, 47.39);
    CGContextAddLineToPoint(ctx, 120.18, 52.16);
    CGContextAddLineToPoint(ctx, 109.91, 65.51);
    CGContextAddLineToPoint(ctx, 110.37, 82.34);
    CGContextAddLineToPoint(ctx, 94.5, 75.7);
    CGContextAddLineToPoint(ctx, 78.63, 82.34);
    CGContextAddLineToPoint(ctx, 79.09, 65.51);
    CGContextAddLineToPoint(ctx, 68.82, 52.16);
    CGContextAddLineToPoint(ctx, 84.98, 47.39);
    CGContextClosePath(ctx);
    
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    
    
    
    
    
    
    
}

@end
