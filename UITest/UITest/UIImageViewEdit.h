//
//  UIImageViewEdit.h
//  TheBackgrounder
//
//  Created by maqinjun on 15/10/21.
//  Copyright © 2015年 Gustavo Ambrozio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageViewEdit : UIView
@property (nonatomic, assign) BOOL editable;
@property (nonatomic, assign) NSInteger maxWords;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *imageDesc;
@property (nonatomic, copy) NSString *placeholder;
@end
