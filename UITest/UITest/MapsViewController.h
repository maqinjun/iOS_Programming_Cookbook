//
//  MapsViewController.h
//  UITest
//
//  Created by maqj on 15/7/8.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapsViewController : UIViewController

@property (nonatomic, strong) MKMapView *mMapView;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end
