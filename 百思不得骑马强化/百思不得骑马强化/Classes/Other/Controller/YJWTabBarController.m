//
//  YJWTabBarController.m
//  百思不得骑马强化
//
//  Created by YJW on 16/10/11.
//  Copyright © 2016年 yijiang. All rights reserved.
//

#import "YJWTabBarController.h"

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
    
    //通过 appearance 设置字体属性
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    attr[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttr = [NSMutableDictionary dictionary];
    selectedAttr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    selectedAttr[NSForegroundColorAttributeName] = [UIColor redColor];
    
    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
    
    //分别创建子控制器
    [self createChildControllerWithController:[[YJWEssenceViewController alloc] init] title:@"最热" img:@"tabBar_essence_icon" selectedImg:@"tabBar_essence_click_icon"];
    
    [self createChildControllerWithController:[[YJWNewViewController alloc] init] title:@"最新" img:@"tabBar_new_icon" selectedImg:@"tabBar_new_click_icon"];
    
    [self createChildControllerWithController:[[YJWFriendViewController alloc] init] title:@"关注" img:@"tabBar_friendTrends_icon" selectedImg:@"tabBar_friendTrends_click_icon"];
    
    [self createChildControllerWithController:[[YJWMeViewController alloc] init] title:@"我" img:@"tabBar_me_icon" selectedImg:@"tabBar_me_click_icon"];

    [self setValue:[[YJWTabBar alloc] init] forKeyPath:@"tabBar"];
}

-(void)createChildControllerWithController:(UIViewController*)vc title:(NSString*)title img:(NSString*)img selectedImg:(NSString*)selectedImg{
    
    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:img];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImg];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}

@end
