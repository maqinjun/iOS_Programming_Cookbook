//
//  CALayerTestViewController.m
//  UITest
//
//  Created by maqj on 29/9/15.
//  Copyright © 2015 maqj. All rights reserved.
//

#import "CALayerTestViewController.h"
#import <QuartzCore/QuartzCore.h>

#define WIDTH (50)
#define PHOTO_HEIGHT (150)

@interface CALayerTestViewController ()

@end


@implementation CALayerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawImage];
    
    [self drawMyLayer];

}

- (void)drawImage{
    
    CGPoint position = CGPointMake(200, 200);
    CGRect bounds = CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    CGFloat borderRadius = PHOTO_HEIGHT/2;
    CGFloat borderWidth = 2;
    
    // 阴影图层
    CALayer *layerShadow = [[CALayer alloc] init];
    layerShadow.bounds = bounds;
    layerShadow.position = position;
    layerShadow.borderWidth = borderWidth;
    layerShadow.cornerRadius = borderRadius;
    layerShadow.borderColor = [UIColor whiteColor].CGColor;
    layerShadow.shadowColor = [UIColor grayColor].CGColor;
    layerShadow.shadowOffset = CGSizeMake(2, 1);
    layerShadow.shadowOpacity = 1;
    
    [self.view.layer addSublayer:layerShadow];
    
    CALayer *layer = [[CALayer alloc] init];
    layer.bounds = bounds;
    layer.position = position;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = borderRadius;
    //如果要正确显示绘制的图片，必须设置masksToBounds = YES，剪切图层
    layer.masksToBounds = YES;
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = borderWidth;
    
    layer.delegate = self;
    
    [self.view.layer addSublayer:layer];
    
    // 调用此函数，否则代理方法不会触发
    [layer setNeedsDisplay];
}

#pragma mark 绘制图形、图像到图层，注意参数中的ctx是图层的图形上下文，其中绘制位置也是相对图层而言
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    
    //图形上下文形变，解决图片倒立的问题
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -PHOTO_HEIGHT);
    
    UIImage *image = [UIImage imageNamed:@"image1.png"];
    
    CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);
    
    CGContextRestoreGState(ctx);
}

#pragma  mark 绘制图层
- (void)drawMyLayer{
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = [UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
    layer.position = CGPointMake(size.width/2, size.height/2);
    layer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
    layer.cornerRadius = WIDTH / 2;
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = .9;
    
    [self.view.layer addSublayer:layer];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    CALayer *layer = [self.view.layer.sublayers lastObject];
    CGFloat width = layer.bounds.size.width;
    
    if (width == WIDTH) {
        width = WIDTH * 3;
    }else{
        width = WIDTH;
    }
    
    layer.bounds = CGRectMake(0, 0, width, width);
    layer.position = [touch locationInView:self.view];
    layer.cornerRadius = width/2;
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
