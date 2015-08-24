//
//  TableViewCell.h
//  UITest
//
//  Created by maqj on 15/7/14.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellTitleView;
@property (weak, nonatomic) IBOutlet UILabel *cellSubtitleView;

@end
