//
//  CoreMotionViewController.m
//  UITest
//
//  Created by maqj on 15/7/16.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "CoreMotionViewController.h"
#import <CoreMotion/CoreMotion.h>

#define ACCELEROMETER_DEBUG (0)
#define GYRO_DEBUG  (1)

@interface CoreMotionViewController ()
@property (nonatomic, strong) CMMotionManager *cmManager;
@end

@implementation CoreMotionViewController

@synthesize cmManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self cmMotionManager];
    
    NSLog(@"%s frame1: %@, bounds1: %@", __FUNCTION__, NSStringFromCGRect(self.view1.frame), NSStringFromCGRect(self.view1.bounds));
    NSLog(@"%s frame2: %@, bounds2: %@", __FUNCTION__, NSStringFromCGRect(self.view2.frame), NSStringFromCGRect(self.view2.bounds));
    
    CGRect bounds =  self.view1.bounds;
    bounds.origin.x = 40;
    bounds.origin.y = 40;
    self.view1.bounds = bounds;
    
    NSLog(@"%s frame1: %@, bounds1: %@", __FUNCTION__, NSStringFromCGRect(self.view1.frame), NSStringFromCGRect(self.view1.bounds));
    NSLog(@"%s frame2: %@, bounds2: %@", __FUNCTION__, NSStringFromCGRect(self.view2.frame), NSStringFromCGRect(self.view2.bounds));

}

- (void)cmMotionManager{
    
    cmManager = [[CMMotionManager alloc] init];
    
    if ([cmManager isAccelerometerAvailable]) {
        NSLog(@"Accelerometer is available.");
        
#if ACCELEROMETER_DEBUG
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        [cmManager
         startAccelerometerUpdatesToQueue:queue
         withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
             NSLog(@"x = %.04f, y = %.04f, z = %.04f",
                   accelerometerData.acceleration.x,
                   accelerometerData.acceleration.y,
                   accelerometerData.acceleration.z);
     
         }];
#endif

    }else{
        NSLog(@"Accelerometer is not available.");
    }
    
    if ([cmManager isAccelerometerActive]) {
        NSLog(@"Accelerometer is active.");
    }else{
        NSLog(@"Accelerometer is not active");
    }
    
    if([cmManager isGyroAvailable]){
        NSLog(@"Gyro is available.");
        
#if GYRO_DEBUG

        if ([cmManager isGyroActive] == NO) {
            [cmManager setGyroUpdateInterval:1.0f/40.0f];
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            
            [cmManager
             startGyroUpdatesToQueue:queue
             withHandler:^(CMGyroData *gyroData, NSError *error) {
                 NSLog(@"Gyro Rotation x = %.04f, y = %.04f, z = %.04f",
                       gyroData.rotationRate.x,
                       gyroData.rotationRate.y,
                       gyroData.rotationRate.z);
             }];
        }
#endif

    }else{
        NSLog(@"Gyro is not available.");
    }
    
    if ([cmManager isGyroActive]) {
        NSLog(@"Gyro is active.");
    }else{
        NSLog(@"Gyro is not active.");
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"The device is shaken.");
    }
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
