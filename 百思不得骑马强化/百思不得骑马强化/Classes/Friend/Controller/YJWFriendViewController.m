//
//  YJWFriendViewController.m
//  百思不得骑马强化
//
//  Created by YJW on 16/10/11.
//  Copyright © 2016年 yijiang. All rights reserved.
//

#import "YJWFriendViewController.h"
#import "YJWRecommendViewController.h"
#import "YJWLoginRegisterViewController.h"

@interface YJWFriendViewController ()

@end

@implementation YJWFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YJWCommonBackGroundColor;
    
    /***  标题  ***/
    self.navigationItem.title = @"我的关注";
    
    /***  左侧按钮  ***/
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightedImage:@"friendsRecommentIcon-click" target:self action:@selector(friendBtnClick)];
    
    YJWFunc;
}

/***  点击左侧按钮  ***/
-(void)friendBtnClick
{
    YJWFunc;
    YJWRecommendViewController *recommend = [[YJWRecommendViewController alloc] init];
    [self.navigationController pushViewController:recommend animated:YES];
}

/***  点击登录注册按钮    ***/
- (IBAction)loginRegister:(id)sender {
    YJWLoginRegisterViewController *loginRegister = [[YJWLoginRegisterViewController alloc] init];
    [self presentViewController:loginRegister animated:YES completion:nil];
}

@end
