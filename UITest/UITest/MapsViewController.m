//
//  MapsViewController.m
//  UITest
//
//  Created by maqj on 15/7/8.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "MapsViewController.h"
#import "MyAnnotation.h"

@interface MapsViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation MapsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mMapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mMapView.mapType = MKMapTypeStandard;
    _mMapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _mMapView.delegate = self;
    _mMapView.showsUserLocation = YES;
    [self.view addSubview:_mMapView];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(50.12325345, 0.12342342);
    
    MyAnnotation *annotation = [[MyAnnotation alloc] initWithCoordinate:coordinate title:@"title" subtitle:@"subtitle"];
    [_mMapView addAnnotation:annotation];
    
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
//        [_locationManager requestAlwaysAuthorization];
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager startUpdatingLocation];
//        [_locationManager startUpdatingHeading];
    }else{
        NSLog(@"Location services are not enabled.");
    }
    
    _geocoder = [[CLGeocoder alloc] init];
    
    /* We have our address */
    NSString *oreillyAddress =
    @"1005 Gravenstein Highway North, Sebastopol, CA 95472, USA";
    
    [_geocoder geocodeAddressString:oreillyAddress
                  completionHandler:^(NSArray *placemarks, NSError *error) {
                      if (error != nil) {
                          NSLog(@"%s %@", __FUNCTION__, error);
                      }else if (placemarks.count == 0){
                          NSLog(@"Found no placemarks.");
                      }else if (placemarks.count >0){
                          NSLog(@"Found %lu placemarks.", placemarks.count);
                          
                          CLPlacemark *firstPlace = placemarks[0];
                          
                          NSLog(@"Latitude = %f, Longitude = %f",
                                firstPlace.location.coordinate.latitude,
                                firstPlace.location.coordinate.longitude);
                      }
    }];
    
    CLLocation *location = [[CLLocation alloc]
                            initWithLatitude:116.404556
                            longitude:39.917591];
    
    [_geocoder reverseGeocodeLocation:location
                    completionHandler:^(NSArray *placemarks, NSError *error) {
                        if (error != nil) {
                            NSLog(@"%s %@", __FUNCTION__, error);
                        }else if (placemarks.count == 0){
                            NSLog(@"Found no placemarks.");
                        }else if (placemarks.count >0){
                            NSLog(@"Found %lu placemarks.", placemarks.count);
                            
                            CLPlacemark *firstPlace = placemarks[0];
                            
                            NSLog(@"Latitude = %f, Longitude = %f",
                                  firstPlace.location.coordinate.latitude,
                                  firstPlace.location.coordinate.longitude);
                            
                            NSLog(@"Country = %@", firstPlace.country);
                            NSLog(@"Postal code = %@", firstPlace.postalCode);
                            NSLog(@"Locality = %@", firstPlace.locality);
                        }
                    }];
}

#pragma mark -- MKMapViewDelegate

- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKAnnotationView *result = nil;
    
    if ([annotation isKindOfClass:[MyAnnotation class]] == NO) {
        return result;
    }
    if ([mapView isEqual:_mMapView] == NO) {
        return result;
    }
    
    MyAnnotation *senderAnnotation = (MyAnnotation*)annotation;
    
    NSString *pinReusableIdentifier = [MyAnnotation reusableIdenfitirefroPinColor:senderAnnotation.pinColor];
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)
    [mapView dequeueReusableAnnotationViewWithIdentifier:pinReusableIdentifier];
    
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc]
                          initWithAnnotation:senderAnnotation
                          reuseIdentifier:pinReusableIdentifier];
        [annotationView setCanShowCallout:YES];
    }
    
    annotationView.pinColor = senderAnnotation.pinColor;
    
    return annotationView;
}

#pragma mark -- CLLocatoinManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    NSLog(@"%s Latitude = %f, Longtitude = %f",__FUNCTION__, manager.location.coordinate.latitude, manager.location.coordinate.longitude);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%s %@", __FUNCTION__, error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    NSLog(@"%s Latitude = %f, Longtitude = %f",__FUNCTION__, manager.location.coordinate.latitude, manager.location.coordinate.longitude);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
