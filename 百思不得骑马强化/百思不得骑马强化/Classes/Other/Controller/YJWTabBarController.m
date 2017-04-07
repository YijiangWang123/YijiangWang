//
//  YJWTabBarController.m
//  百思不得骑马强化
//
//  Created by YJW on 16/10/11.
//  Copyright © 2016年 yijiang. All rights reserved.
//

#import "YJWTabBarController.h"
#import "YJWNavigationController.h"

#import "YJWEssenceViewController.h"
#import "YJWNewViewController.h"
#import "YJWFriendViewController.h"
#import "YJWMeViewController.h"

#import "YJWTabBar.h"

@interface YJWTabBarController ()

@end

@implementation YJWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /***  设置item标题  ***/
    [self setUpItemTitle];
    
    /***  创建子控制器  ***/
    [self setUpChildControllers];

    /***  自定义tabBar  ***/
    [self setValue:[[YJWTabBar alloc] init] forKeyPath:@"tabBar"];
}

/***  setUpItemTitle  ***/
-(void)setUpItemTitle
{
    //通过 appearance 设置所有 tabBarItem 字体属性
    UITabBarItem *item = [UITabBarItem appearance];
    //设置普通状态下样式
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    attr[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
    //设置选中时样式
    NSMutableDictionary *selectedAttr = [NSMutableDictionary dictionary];
    selectedAttr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    selectedAttr[NSForegroundColorAttributeName] = [UIColor redColor];
    [item setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
}

/***  setUpChildControllers  ***/
-(void)setUpChildControllers
{
    /***  分别创建子控制器  ***/
    [self createChildControllerWithController:[[YJWEssenceViewController alloc] init] title:@"最热" img:@"tabBar_essence_icon" selectedImg:@"tabBar_essence_click_icon"];
    [self createChildControllerWithController:[[YJWNewViewController alloc] init] title:@"最新" img:@"tabBar_new_icon" selectedImg:@"tabBar_new_click_icon"];
    [self createChildControllerWithController:[[YJWFriendViewController alloc] init] title:@"关注" img:@"tabBar_friendTrends_icon" selectedImg:@"tabBar_friendTrends_click_icon"];
    [self createChildControllerWithController:[[YJWMeViewController alloc] init] title:@"我" img:@"tabBar_me_icon" selectedImg:@"tabBar_me_click_icon"];

}

/**
 创建子控制器

 @param vc 传入的控制器
 @param title tabbar标题
 @param img 图片
 @param selectedImg 选中的图片
 */
-(void)createChildControllerWithController:(UIViewController*)vc title:(NSString*)title img:(NSString*)img selectedImg:(NSString*)selectedImg{
    
    //在各个控制器里单独设置背景颜色，否则会在初始化时候创建所有控制器
//    vc.view.backgroundColor = YJWRandomColor;
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:img];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImg];
    
    YJWNavigationController *nav = [[YJWNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}

@end
