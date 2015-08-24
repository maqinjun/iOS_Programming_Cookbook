//
//  MyAnnotation.m
//  UITest
//
//  Created by maqj on 15/7/8.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "MyAnnotation.h"

NSString *const kReusablePinRed = @"Red";
NSString *const kReusablePinGreen = @"Green";
NSString *const kReusablePinPurple = @"Purple";

@implementation MyAnnotation

@synthesize coordinate, title, subtitle, pinColor;

+ (NSString*)reusableIdenfitirefroPinColor:(MKPinAnnotationColor)paramColor{
    NSString *result = nil;
    
    switch (paramColor) {
        case MKPinAnnotationColorGreen:
            result = kReusablePinGreen;
            break;
        case MKPinAnnotationColorPurple:
            result = kReusablePinPurple;
            break;
        case MKPinAnnotationColorRed:
            result = kReusablePinRed;
            break;
        default:
            break;
    }
    
    return result;
}

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)curCoordinate title:(NSString*)curTitle subtitle:(NSString*)subTitle{
    self = [super init];
    
    if (self) {
        coordinate = curCoordinate;
        title = curTitle;
        subtitle = subTitle;
        pinColor = MKPinAnnotationColorGreen;
    }
    
    return self;
}

@end
