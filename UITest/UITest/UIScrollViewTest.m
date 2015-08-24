//
//  UIScrollViewTest.m
//  UITest
//
//  Created by maqj on 15/6/21.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "UIScrollViewTest.h"

@interface UIScrollViewTest ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *mImageView;
@property (nonatomic, strong) UIScrollView *mScrollView;

@end
@implementation UIScrollViewTest

-(void)viewDidLoad{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.title = @"UIScrollView";
    
//    [self initWithOneImage];
    [self initWithSameImage];

}

-(UIImageView*)newImageViewWithImage:(UIImage*)image frame:(CGRect)rect{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = image;
    return imageView;
}

-(void)initWithSameImage{
    UIImage *image1 = [UIImage imageNamed:@"UIScrollViewTestIcon"];
    UIImage *image2 = [UIImage imageNamed:@"UIScrollViewTestIcon1"];
    UIImage *image3 = [UIImage imageNamed:@"UIScrollViewTestIcon2"];
    UIImage *image4 = [UIImage imageNamed:@"UIScrollViewTestIcon3"];
    
    CGRect imageRect = self.view.bounds;
    
    self.mScrollView = [[UIScrollView alloc] initWithFrame:imageRect];
    self.mScrollView.pagingEnabled = YES;
    self.mScrollView.delegate = self;
    self.mScrollView.showsVerticalScrollIndicator = NO;
    self.mScrollView.contentSize = CGSizeMake(imageRect.size.width*4.0f, imageRect.size.height-200);

    UIImageView *imageView1 = [self newImageViewWithImage:image1 frame:imageRect];
    imageRect.origin.x += imageRect.size.width;
    UIImageView *imageView2 = [self newImageViewWithImage:image2 frame:imageRect];
    imageRect.origin.x += imageRect.size.width;
    UIImageView *imageView3 = [self newImageViewWithImage:image3 frame:imageRect];
    imageRect.origin.x += imageRect.size.width;
    UIImageView *imageView4 = [self newImageViewWithImage:image4 frame:imageRect];
    
    [self.mScrollView addSubview:imageView1];
    [self.mScrollView addSubview:imageView2];
    [self.mScrollView addSubview:imageView3];
    [self.mScrollView addSubview:imageView4];
    
    [self.view addSubview:self.mScrollView];
}

-(void)initWithOneImage{
    [self initImageView];
    [self initScrollView];
    
    [self.view addSubview:self.mScrollView];
    [self.mScrollView addSubview:self.mImageView];
}

-(void)initScrollView{
    self.mScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.mScrollView.delegate = self;
    CGSize scrollSize = self.mImageView.bounds.size;
//    scrollSize.width += 1000;
    self.mScrollView.contentSize = scrollSize;
//    self.mScrollView.showsHorizontalScrollIndicator = YES;
//    self.mScrollView.showsVerticalScrollIndicator = YES;
//    self.mScrollView.scrollEnabled = YES;
    
    self.mScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
}

-(void)initImageView{
    self.mImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"UIScrollViewTestIcon1"]];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    scrollView.alpha = 0.50f;
    NSLog(@"scrollViewDidScroll");
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    scrollView.alpha = 1.0f;
    NSLog(@"scrollViewDidEndDecelerating");
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"scrollViewDidEndDragging: decelerate = %d", decelerate);
    scrollView.alpha = 1.0f;
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndScrollingAnimation");
}

@end
