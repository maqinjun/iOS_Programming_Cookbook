//
//  UIPageViewControllerTest.m
//  UITest
//
//  Created by maqj on 15/6/22.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "UIPageViewControllerTest.h"
#import "UIViewControllerPage.h"

@interface UIPageViewControllerTest ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@end
@implementation UIPageViewControllerTest

-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource = self;
    self.delegate = self;
//    self.spineLocation = UIPageViewControllerSpineLocationMid;
    
    UIViewControllerPage *pageViewL = [[UIViewControllerPage alloc] init];
    [pageViewL setPageDetail:@"Page Left"];
    pageViewL.index = 2;
    
    UIViewControllerPage *pageViewR = [[UIViewControllerPage alloc] init];
    [pageViewR setPageDetail:@"Page Right"];
    pageViewR.index = 3;
    
//    UIView *v;
    
    NSArray *curPages = nil;
    
    if (self.spineLocation == UIPageViewControllerSpineLocationMid) {
        curPages = @[pageViewL, pageViewR];
    }else{
        curPages = @[pageViewL];
    }
    
    [self setViewControllers:curPages direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        NSLog(@"completion");
    }];
}

#pragma mark -- UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSLog(@"viewControllerBeforeViewController");
    
    UIViewControllerPage *curPage = (UIViewControllerPage*)viewController;
    
    if (curPage.index == 0) {
        return nil;
    }
    
    UIViewControllerPage *pageView = [[UIViewControllerPage alloc] init];
    
    [pageView setPageDetail:@"Page Before"];
    [pageView setIndex:curPage.index-1];
    
    return pageView;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSLog(@"viewControllerAfterViewController");
    
    UIViewControllerPage *curPage = (UIViewControllerPage*)viewController;
    
    if (curPage.index == 5) {
        return nil;
    }
    
    UIViewControllerPage *pageView = [[UIViewControllerPage alloc] init];
    [pageView setPageDetail:@"Page After"];
    pageView.index = curPage.index+1;
    
    return pageView;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    NSLog(@"didFinishAnimating: %d, %@, %d", finished, previousViewControllers, completed);
}

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers{
    NSLog(@"willTransitionToViewControllers: %@", pendingViewControllers);
}

//-(void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion{
//    
//}

@end
