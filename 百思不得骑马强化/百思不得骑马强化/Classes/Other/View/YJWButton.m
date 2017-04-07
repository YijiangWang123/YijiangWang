//
//  YJWButton.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/16.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWButton.h"

@implementation YJWButton

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.yjw_y =0;
    self.imageView.yjw_centerX = self.yjw_width * 0.5;
    
    self.titleLabel.yjw_x = 0;
    self.titleLabel.yjw_y = self.imageView.yjw_height;
    self.titleLabel.yjw_width = self.yjw_width;
    self.titleLabel.yjw_height = self.yjw_height - self.imageView.yjw_height;
}

@end
