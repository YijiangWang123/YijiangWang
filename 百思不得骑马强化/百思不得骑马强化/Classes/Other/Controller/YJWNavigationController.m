//
//  YJWNavigationController.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/15.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWNavigationController.h"

/*
 当重写pushViewController:animated:时，左滑手势会失效，这时要实现手势的代理方法
 */

@interface YJWNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation YJWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //pop 和 push 时，navigationBar 右侧会出现灰色区域，解决方案：设置背景图片
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];

    //实现左滑手势
    self.interactivePopGestureRecognizer.delegate = self;
}

/**
 拦截所有导航控制器

 @param viewController <#viewController description#>
 @param animated <#animated description#>
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.hidesBottomBarWhenPushed = YES;
        [backBtn sizeToFit];
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - <UIGestureRecognizerDelegate>
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //设置当 childViewControllers.count > 1 时，pop手势才有效
    return self.childViewControllers.count > 1;
}

@end
