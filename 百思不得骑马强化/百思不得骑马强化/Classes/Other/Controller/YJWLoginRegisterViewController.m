//
//  YJWLoginRegisterViewController.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/16.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWLoginRegisterViewController.h"

@interface YJWLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewConstraint;

@end

@implementation YJWLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _login.layer.cornerRadius = 5;
//    _login.layer.masksToBounds = YES;
}

/***  设置状态栏颜色  ***/
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/***  切换登录/注册按钮  ***/
- (IBAction)switchBtn:(UIButton *)sender
{
    //回退键盘
    [self.view endEditing:YES];
    
    //修改约束
    if (self.loginViewConstraint.constant) {
        [sender setTitle:@"注册账号" forState:UIControlStateNormal];
        self.loginViewConstraint.constant = 0;
    }else{
        [sender setTitle:@"已有账号" forState:UIControlStateNormal];
        self.loginViewConstraint.constant = - self.view.yjw_width;
    }
    
    //设置动画
    [UIView animateWithDuration:0.25 animations:^{
        //强制布局
        [self.view layoutIfNeeded];
    }];
}

/***  关闭按钮  ***/
- (IBAction)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/***  点击屏幕回退键盘  ***/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
