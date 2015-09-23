//
//  ShapesUIView.m
//  UITest
//
//  Created by maqj on 15/7/16.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "ShapesUIView.h"

@implementation ShapesUIView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
        
//    [self movingShapesDrawn];
    
    [self shapesDrawnCTM];
}

- (void)shapesDrawnCTM{
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect rect = CGRectMake(10.0f, 140.0f, 50.0f, 50.0f);
    
    CGPathAddRect(path, NULL, rect);
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(contextRef);
    
    CGContextTranslateCTM(contextRef, 100.0f, 0.0f);
    
    CGContextAddPath(contextRef, path);
    
    [[UIColor redColor] setFill];
    
    [[UIColor blackColor] setStroke];
    
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    
    CGPathRelease(path);
    
    CGContextRestoreGState(contextRef);
    
}

- (void)movingShapesDrawn{
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGRect rect = CGRectMake(10.0f, 80.0f, 50.0f, 50.0f);
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(100.0f, 0.0f);
    
//    CGAffineTransform transform = CGAffineTransformMakeRotation((45.0f * M_PI) / 180.0f);
    
    CGPathAddRect(path, &transform, rect);
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGContextAddPath(contextRef, path);
    
    CGPathRelease(path);
    
    [[UIColor blackColor] setFill];
    [[UIColor greenColor] setStroke];
    
    CGContextSetLineWidth(contextRef, 5.0f);
    
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    
//    CGContextRelease(contextRef);
}

@end
