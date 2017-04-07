//
//  YJWNewViewController.m
//  百思不得骑马强化
//
//  Created by YJW on 16/10/11.
//  Copyright © 2016年 yijiang. All rights reserved.
//

#import "YJWNewViewController.h"

@interface YJWNewViewController ()

@end

@implementation YJWNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YJWCommonBackGroundColor;
    
    /***  标题视图  ***/
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main"]];
    
    /***  左边按钮  ***/
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_coin_icon" highlightedImage:@"nav_coin_icon_click" target:self action:@selector(newTagClick)];
    
    YJWFunc;
}

/***  点击左侧按钮  ***/
-(void)newTagClick
{
    YJWFunc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
