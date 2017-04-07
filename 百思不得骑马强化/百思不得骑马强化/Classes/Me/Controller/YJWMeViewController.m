//
//  YJWMeViewController.m
//  百思不得骑马强化
//
//  Created by YJW on 16/10/11.
//  Copyright © 2016年 yijiang. All rights reserved.
//

#import "YJWMeViewController.h"
#import "YJWSettingViewController.h"
#import "YJWMeCell.h"
#import "YJWFooterView.h"

@implementation YJWMeViewController

-(instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTable];
    
    [self setNav];
}

-(void)setTable
{
    self.tableView.backgroundColor = YJWCommonBackGroundColor;
    
    /***  设置headerView 和footerView  ***/
    self.tableView.contentInset = UIEdgeInsetsMake(YJWMargin - 35, 0, 0, 0);
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = YJWMargin;
    
    /***  footerView  ***/
    YJWFooterView *footerView = [[YJWFooterView alloc] init];
    self.tableView.tableFooterView = footerView;
}

-(void)setNav
{
    /***  标题  ***/
    self.navigationItem.title = @"我";
    
    /***  右侧按钮  ***/
    //设置按钮
    UIBarButtonItem *settintItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click" target:self action:@selector(settingBtnClick)];
    //夜间模式按钮
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightedImage:@"mine-moon-icon-click" target:self action:@selector(moonBtnClick)];
    self.navigationItem.rightBarButtonItems = @[settintItem,moonItem];
}

/***  点击设置按钮  ***/
-(void)settingBtnClick
{
    YJWSettingViewController *settingVC = [[YJWSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

/***  点击夜间模式按钮  ***/
-(void)moonBtnClick
{
    YJWFunc;
}

#pragma - mark 实现数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"me";
    
    YJWMeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[YJWMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (indexPath.section ==0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
    }else{
        cell.textLabel.text = @"点击下载";
        //防止cell重复利用，造成图片显示错乱
        cell.imageView.image = nil;
    }
    
    return cell;
}
 
@end
