//
//  ViewController.m
//  UITest
//
//  Created by maqj on 15/4/14.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "ViewController.h"
#import "KeychainItemWrapper.h"
#import <Security/Security.h>
#import <MDMSDK/MDMSDK.h>

@interface ViewController ()<UITextFieldDelegate>
- (IBAction)saveUUID:(id)sender;

@end

#define ScreenX ([UIScreen mainScreen].bounds.size.width)
#define ScreenY ([UIScreen mainScreen].bounds.size.height)

@implementation ViewController
{
    UIButton *downButton;
    UIView *subView;
    
    dispatch_block_t block;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    subView = [[UIView alloc] init];
    
    UIDevice *device = [UIDevice currentDevice];
    
    NSUUID *uuid = device.identifierForVendor;
    NSLog(@"--->%@", uuid.UUIDString);
    
    [self testTextFiledView];
    [self testTitleView];
    
    [self testTextView];
    
    [self testProgressView];
    
    NSOperation *op;
    [op cancel];
    
    [UIView animateWithDuration:0.2 animations:^{
        
    }];
   
    [self test:^{
        NSLog(@"test");
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.mTextView.alpha = 0.5f;
    }];
    
    block = ^{
        self.mTextView.alpha = 0.8f;
    };
    
//    [NSData dataWithContentsOfURL:<#(nonnull NSURL *)#> options:<#(NSDataReadingOptions)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>]
    
//    [subView addObserver:<#(nonnull NSObject *)#> forKeyPath:<#(nonnull NSString *)#> options:<#(NSKeyValueObservingOptions)#> context:<#(nullable void *)#>]
    
//    NSRunLoop *loop = [[NSRunLoop alloc] init];
//    [loop runMode:<#(nonnull NSString *)#> beforeDate:<#(nonnull NSDate *)#>]
    
//    [NSThread detachNewThreadSelector:<#(nonnull SEL)#> toTarget:<#(nonnull id)#> withObject:<#(nullable id)#>]
//    dispatch_async(dispatch_get_main_queue(), block);
    
//    [UIView animateWithDuration:(NSTimeInterval) animations:;]
    CALayer *layer = [[CALayer alloc] init];
//    layer.
    UIImageView *image;
//    [image setImage:<#(UIImage * _Nullable)#>];
//    [image setImage:];
    UIButton *button;
//    [button setImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>];
    
//    self.view.layer
    
}

- (void)dealloc{
    NSLog(@"%s", __FUNCTION__);
}

- (void)loadView{
    [super loadView];
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)willChange:(NSKeyValueChange)changeKind valuesAtIndexes:(NSIndexSet *)indexes forKey:(NSString *)key{
    
}

- (void)didChange:(NSKeyValueChange)changeKind valuesAtIndexes:(NSIndexSet *)indexes forKey:(NSString *)key{
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
}

- (void)test:(void(^)(void))block{
 
    block();
}

-(void)testTextView{
    self.mTextView.backgroundColor = [UIColor grayColor];
    self.mTextView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    
    UILabel *textViewTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, -100, 100, 30)];
    textViewTitle.text = @"Just focking test.";
    textViewTitle.textColor = [UIColor whiteColor];
    textViewTitle.adjustsFontSizeToFitWidth = YES;
    [self.mTextView addSubview:textViewTitle];
}

-(void)testProgressView{
    CGRect frame = self.mProgressView.frame;
    frame.size.height = 100;
    self.mProgressView.frame = frame;
    self.mProgressView.transform =  CGAffineTransformMakeScale(1.0f, 10.0f);
}

-(void)testTitleView{
    UIButton *download = [UIButton buttonWithType:UIButtonTypeSystem];
    [download setTitle:@"Download" forState:UIControlStateNormal];
    [download addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = download;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEditing");
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldEndEditing");
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldBeginEditing");
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //NSLog(@"shouldChangeCharactersInRange, range:(%lu, %lu), replaceStr: %@", range.location, (unsigned long)range.length, string);
    self.mTextView.text = self.mUUIDTextFiledView.text;
    
    return YES;
}

-(void)testTextFiledView{
    UILabel *currencyLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
    currencyLabel1.text = [[[NSNumberFormatter alloc] init] currencySymbol];
    currencyLabel1.font = self.mUUIDTextFiledView.font;
    currencyLabel1.text = @"我是你妹\"";
    [currencyLabel1 sizeToFit];
    
    UILabel *currencyLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
    currencyLabel2.text = [[[NSNumberFormatter alloc] init] currencySymbol];
    currencyLabel2.font = self.mUUIDTextFiledView.font;
    currencyLabel2.text = @"\"你是她哥";
    [currencyLabel2 sizeToFit];
    
    //    self.UUIDTextFiledView.text = [[UUIDTool shareUUIDTool] getDeviceUUID];
    self.mUUIDTextFiledView.placeholder = @"请输入你妹";
    self.mUUIDTextFiledView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.mUUIDTextFiledView.leftView = currencyLabel1;
    self.mUUIDTextFiledView.leftViewMode = UITextFieldViewModeAlways;
    self.mUUIDTextFiledView.rightView = currencyLabel2;
    self.mUUIDTextFiledView.rightViewMode = UITextFieldViewModeAlways;
    self.mUUIDTextFiledView.delegate = self;
    //    self.UUIDTextFiledView.inputView = currencyLabel2;
    
    NSLog(@"1 %f", self.mUUIDTextFiledView.frame.origin.y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)done:(id)sender{
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = downButton.frame;
        frame.origin.y += 50;
        frame.size.height = 0;
        frame.size.width = 0;
        frame.origin.x = ScreenX/2;
        downButton.frame = frame;
//        downButton.transform
        subView.alpha = 0;

    } completion:^(BOOL finished) {
        [subView removeFromSuperview];
        [downButton removeFromSuperview];
    }];
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5];
//    [UIView commitAnimations];
}

-(IBAction)download:(id)sender{
     NSString *str = @"itms-services://?action=download-manifest&url=https://192.168.4.91:8443/ThundersoftMDMWeb/resources/assets/QQ.plist";
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
    UILabel *bgTestLabel = [[UILabel alloc] initWithFrame:CGRectMake(200.0f, 200.0f, 100.0f, 50.0f)];
    bgTestLabel.text = @"I'm comming.";
    bgTestLabel.textColor = [UIColor blackColor];
    bgTestLabel.backgroundColor = [UIColor whiteColor];
    
    [subView addSubview:bgTestLabel];
    
    CGRect subViewFrame = [UIScreen mainScreen].bounds;
    subViewFrame.size.height -= 50;
    subView.frame = subViewFrame;
    subView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8f];
//    subView.alpha = 0;
//    subView.alpha = 0.0f;
//    subView.backgroundColor = [UIColor blackColor];
    UIGestureRecognizer *subViewTouchRgzer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(done:)];
    [subView addGestureRecognizer:subViewTouchRgzer];
    
    downButton.frame = CGRectMake(ScreenX/2, ScreenY, 0, 0);
    downButton.backgroundColor = [UIColor whiteColor];
    [downButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [downButton setTitle:@"Download" forState:UIControlStateNormal];
    [downButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect frame = downButton.frame;
        frame.origin.y -= 50;
        frame.origin.x = 0;
        frame.size.width = ScreenX;
        frame.size.height = 50;
        downButton.frame = frame;
        
//        subView.alpha = 0.2;

    } completion:^(BOOL finished) {
        
    }];
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5];
//    CGRect frame = downButton.frame;
//    frame.origin.y -= 50;
//    frame.origin.x = 0;
//    frame.size.width = ScreenX;
//    frame.size.height = 50;
//    downButton.frame = frame;
//    
//    subView.alpha = 0.5;
//   
//    [UIView commitAnimations];
    
//    [subView addSubview:downButton];
    [self.navigationController.view addSubview:subView];
    [self.navigationController.view addSubview:downButton];
}

- (IBAction)saveUUID:(id)sender {
    
    [self.mUUIDTextFiledView resignFirstResponder];
    [self.mTextView resignFirstResponder];

//    [[UUIDTool shareUUIDTool] saveDeviceUUID:self.UUIDTextFiledView.text];
}

-(IBAction)undo:(id)sender{
    self.mUUIDTextFiledView.text = @"";
    self.mTextView.text = @"";
    NSLog(@"2 %f", self.mUUIDTextFiledView.frame.origin.y);
    
    CGRect lastFrame = self.mUUIDTextFiledView.frame;

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelay:0.1];
    
    lastFrame.origin.y += 20;
    self.mUUIDTextFiledView.frame = lastFrame;
    
    [UIView commitAnimations];

    /*
    [UIView animateWithDuration:1 animations:^{
        NSLog(@"test");
        CGRect lastFrame = self.mUUIDTextFiledView.frame;
        lastFrame.origin.y += 20;

        self.mUUIDTextFiledView.frame = lastFrame;
        NSLog(@"3 %f", self.mUUIDTextFiledView.frame.origin.y);

    }];
     */
}
@end
