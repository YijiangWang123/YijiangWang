//
//  YJWTabBar.m
//  百思不得骑马强化
//
//  Created by YJW on 16/10/12.
//  Copyright © 2016年 yijiang. All rights reserved.
//

#import "YJWTabBar.h"

@interface YJWTabBar ()

/** 按钮   */
@property(nonatomic,weak) UIButton *publishBtn;

@end

@implementation YJWTabBar

/***  懒加载  ***/
-(UIButton *)publishBtn
{
    if (!_publishBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = YJWRandomColor;
        [button setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        _publishBtn = button;
    }
    return _publishBtn;
}


/**
 设置背景图片

 @param frame <#frame description#>
 @return <#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    }
    return self;
}

/***  布局子控件  ***/
-(void)layoutSubviews{
    [super layoutSubviews];
    // 按钮尺寸
    CGFloat itemH = self.yjw_height;
    CGFloat itemW = self.yjw_width / 5;
    CGFloat itemY = 0;
    //按钮索引
    int itemIndex = 0;
    
    /***  布局item  ***/
    for (UIView *subView in self.subviews) {
        //过滤掉非UITabBarButton的子控件
        if (![@"UITabBarButton" isEqualToString:NSStringFromClass([subView class])]) continue;
        
        CGFloat itemX = itemW * itemIndex;
        if (itemIndex >= 2) {
            itemX += itemW;
        }
        subView.frame = CGRectMake(itemX, itemY, itemW, itemH);
        itemIndex++;
    }
    
    //布局 publishBtn
    self.publishBtn.yjw_width = itemW;
    self.publishBtn.yjw_height = itemH;
    self.publishBtn.yjw_centerX = self.yjw_width * 0.5;
    self.publishBtn.yjw_centerY = self.yjw_height * 0.5;
//    self.publishBtn.bounds = CGRectMake(0, 0, itemW, itemH);
//    self.publishBtn.center = CGPointMake(self.yjw_width * 0.5, self.yjw_height * 0.5);
}

-(void)publishClick
{
    YJWFunc;
}

@end
