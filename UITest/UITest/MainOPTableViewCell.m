//
//  MainOPTableViewCell.m
//  UITest
//
//  Created by maqj on 15/8/26.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "MainOPTableViewCell.h"

@implementation MainOPTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.label.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
