//
//  YJWMeCell.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/19.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWMeCell.h"

@implementation YJWMeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        //设置图片大小模式
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        //设置cell 背景
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        //cell的指示器模式
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //设置cell字体
        self.textLabel.textColor = [UIColor darkGrayColor];
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    
    self.imageView.yjw_y = 5;
    self.imageView.yjw_height = self.yjw_height - self.imageView.yjw_y * 2;
}

@end
