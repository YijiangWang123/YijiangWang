//
//  YJWSquareButton.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/20.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWSquareButton.h"
#import "YJWMeSquare.h"
#import <UIButton+WebCache.h>

@implementation YJWSquareButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.yjw_y = self.yjw_height * 0.2;
    self.imageView.yjw_width = self.yjw_width * 0.5;
    self.imageView.yjw_height = self.imageView.yjw_width;
    self.imageView.yjw_centerX = self.yjw_width * 0.5;
    /***  曾经的坑爹bug  ***/
//    self.imageView.yjw_centerX = self.yjw_centerX;

    self.titleLabel.yjw_x = 0;
    self.titleLabel.yjw_y = self.imageView.yjw_bottom;
    self.titleLabel.yjw_width = self.yjw_width;
    self.titleLabel.yjw_height = self.yjw_height - self.titleLabel.yjw_y;
}

-(void)setSquare:(YJWMeSquare *)square
{
    _square = square;
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"mine-icon-activity"]];
}

@end
