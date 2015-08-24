//
//  NewsItem.h
//  UITest
//
//  Created by maqj on 15/7/11.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, copy) NSString *text;
@end
