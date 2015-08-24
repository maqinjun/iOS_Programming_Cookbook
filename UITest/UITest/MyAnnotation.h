//
//  MyAnnotation.h
//  UITest
//
//  Created by maqj on 15/7/8.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>


@property (nonatomic, readonly, unsafe_unretained) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;

@property (nonatomic, unsafe_unretained) MKPinAnnotationColor pinColor;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString*)title subtitle:(NSString*)subTitle;

+ (NSString*)reusableIdenfitirefroPinColor:(MKPinAnnotationColor)paramColor;

@end
