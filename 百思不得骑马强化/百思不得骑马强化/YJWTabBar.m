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
@property(nonatomic,strong) UIButton *btn;

@end

@implementation YJWTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [self addSubview:btn];
        
        self.btn = btn;
    }
    
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    //设置按钮大小和位置
    CGFloat btnW = self.btn.currentBackgroundImage.size.width;
    CGFloat btnH = self.btn.currentBackgroundImage.size.height;
    self.btn.frame = CGRectMake(0, 0, btnW, btnH);
    self.btn.center = CGPointMake(width/2, height/2);
    
    //设置 tabBarItem位置
    int index = 0;
    CGFloat w = width/5;
    
    for (UIView *btn in self.subviews) {
        if (![btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        CGFloat x = w*((index>1)?(index+1):index);
        
        btn.frame = CGRectMake(x, 0, w, height);
        
        index++;
    }
}

@end
