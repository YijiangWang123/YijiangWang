//
//  YJWEssenceViewController.m
//  百思不得骑马强化
//
//  Created by YJW on 16/10/11.
//  Copyright © 2016年 yijiang. All rights reserved.
//

#import "YJWEssenceViewController.h"

@interface YJWEssenceViewController ()

/** 记录选中的按钮   */
@property(nonatomic,strong) UIButton *selectedBtn;
/** 指示器   */
@property(nonatomic,strong) UIView *indicator;

@end

@implementation YJWEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTitleView];
}

/*
 ** 添加标题视图
 */
-(void)addTitleView
{
    //创建标题 View
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    titleView.y = 64;
    titleView.height = 35;
    titleView.width = self.view.width;
    [self.view addSubview:titleView];
    
    NSArray *titles = @[@"全部内容",@"视频",@"图片",@"段子",@"音频"];
    CGFloat height = titleView.height;
    CGFloat width = titleView.width / titles.count;
    
    //创建 btn
    for (int i=0; i<titles.count; i++) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.x = width * i;
        titleBtn.width = width;
        titleBtn.height = height;
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [titleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleBtn];
    }
    
    //导航标签
    UIView *indicator = [[UIView alloc] init];
    indicator.backgroundColor = [UIColor redColor];
    indicator.height = 2;
    indicator.y = titleView.height - indicator.height;
    self.indicator = indicator;
    [titleView addSubview:indicator];
}

/**
 点击标题
 @param btn 按钮
 */
-(void)titleClick:(UIButton *)btn
{
    //更改按钮选中状态
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    YJWFunc;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicator.width = btn.titleLabel.width;
        self.indicator.centerX = btn.centerX;
    }];
}

@end
