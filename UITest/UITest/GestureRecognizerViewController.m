//
//  GestureRecognizerViewController.m
//  UITest
//
//  Created by maqj on 15/7/8.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "GestureRecognizerViewController.h"
#import <Social/Social.h>

@interface GestureRecognizerViewController ()

@property (nonatomic, strong) UISwipeGestureRecognizer *swipeGestureRecognizer;
@property (nonatomic, strong) UIRotationGestureRecognizer *rotationGestureRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGesturerRecognizer;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *helloLabel;
@property (nonatomic, unsafe_unretained) CGFloat rotationAngleInRadians;
@property (nonatomic, unsafe_unretained) CGRect imageFrame;

@end

@implementation GestureRecognizerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initImageView];
    
    [self initSwipeGesture];
    
    [self initLable];
    
    [self initRotationGesture];
    
    [self initPanGesture];
    
    [self initPinchGesture];
    
    [self initSocialView];
    
}

- (void)initImageView{
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.image = [UIImage imageNamed:@"PinchGestureImage"];
    [self.view addSubview:self.imageView];
    self.imageFrame = self.imageView.frame;
}

- (void)initPinchGesture{
    self.pinchGesturerRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                             action:@selector(handlePinchGesture:)];
    [self.view addGestureRecognizer:self.pinchGesturerRecognizer];
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer*)pinchGesture{
    if (pinchGesture.state != UIGestureRecognizerStateEnded||
        pinchGesture.state != UIGestureRecognizerStateFailed) {
    
        self.imageView.frame = self.imageFrame;
        
        CGRect frame = self.imageFrame;
        frame.size.width *= (pinchGesture.scale);
        frame.size.height *= (pinchGesture.scale);
        self.imageFrame = frame;
//        self.imageFrame.size.width *= pinchGesture.scale;
//        self.imageFrame.size.height *= pinchGesture.scale;        
    }
}

- (void)initSocialView{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        [controller setInitialText:@"I'm twitter king."];
        [controller addURL:[NSURL URLWithString:@"https://www.baidu.com"]];
        controller.completionHandler = ^(SLComposeViewControllerResult result){
            NSLog(@"%s %d", __FUNCTION__, result);
        };
        
        [self presentViewController:controller animated:YES completion:nil];
        
    }else{
        NSLog(@"The twitter service is not available");
    }
}

- (void)initLable{
    self.helloLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.helloLabel.text = @"Hello World.";
    self.helloLabel.center = self.view.center;
    self.helloLabel.userInteractionEnabled = YES;
    [self.helloLabel sizeToFit];
    self.helloLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:self.helloLabel];
}

- (void)initPanGesture{
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(handlePanGesture:)];
    self.panGestureRecognizer.minimumNumberOfTouches = 1;
    self.panGestureRecognizer.maximumNumberOfTouches = 1;
    [self.helloLabel addGestureRecognizer:self.panGestureRecognizer];
}

- (void)initRotationGesture{
    self.rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc]
                                      initWithTarget:self
                                      action:@selector(handleRotationGesture:)];
    [self.view addGestureRecognizer:self.rotationGestureRecognizer];
}

- (void)initSwipeGesture{
    self.swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(handleSwipe:)];
    self.swipeGestureRecognizer.numberOfTouchesRequired = 1;
    self.swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.swipeGestureRecognizer];
}

- (void)handlePanGesture:(UIPanGestureRecognizer*)panGesture{
    if (panGesture.state != UIGestureRecognizerStateEnded &&
        panGesture.state != UIGestureRecognizerStateFailed) {
        CGPoint location = [panGesture locationInView:panGesture.view.superview];
        
        panGesture.view.center = location;
    }
}

- (void)handleRotationGesture:(UIRotationGestureRecognizer*)rotationGesture{
    if (self.helloLabel == nil) {
        return;
    }
    
    self.helloLabel.transform =
    CGAffineTransformMakeRotation(self.rotationAngleInRadians + rotationGesture.rotation);
    
    if (rotationGesture.state == UIGestureRecognizerStateEnded) {
        self.rotationAngleInRadians += rotationGesture.rotation;
    }
}

- (void)handleSwipe:(UISwipeGestureRecognizer*)gestureRecognizer{
    if (gestureRecognizer.direction & UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"Swipe Down.");
    }else if(gestureRecognizer.direction & UISwipeGestureRecognizerDirectionLeft){
        NSLog(@"Swipe Left.");
    }else if(gestureRecognizer.direction & UISwipeGestureRecognizerDirectionRight){
        NSLog(@"Swipe Right");
    }else if(gestureRecognizer.direction & UISwipeGestureRecognizerDirectionUp){
        NSLog(@"Swipe Up.");
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
