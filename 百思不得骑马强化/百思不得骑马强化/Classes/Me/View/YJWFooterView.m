//
//  YJWFooterView.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/20.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWFooterView.h"
#import <MJExtension.h>
#import "YJWHttpSessionManager.h"

#import "YJWMeSquare.h"
#import "YJWSquareButton.h"
#import "YJWWebViewController.h"
#import <SafariServices/SafariServices.h>

@implementation YJWFooterView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        //参数
        NSMutableDictionary *paras = [NSMutableDictionary dictionary];
        paras[@"a"] = @"square";
        paras[@"c"] = @"topic";
        //发送请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:paras progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {

            NSArray *squaresArr = [YJWMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            [self createSquare:squaresArr];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败---%@",error);
        }];
    }
    
    return self;
}

-(void)createSquare:(NSArray *)squares
{
    NSInteger index = squares.count;
    
    /***  图标宽高  ***/
    NSInteger columnNum = 4;
    CGFloat btnW = self.yjw_width / columnNum;
    CGFloat btnH = btnW;
    
    for (int i=0; i<index; i++) {
        
        /***  创建按钮  ***/
        YJWSquareButton *btn = [YJWSquareButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(squareClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        /***  设置按钮frame  ***/
        CGFloat btnX = i % columnNum * btnW;
        CGFloat btnY = i / columnNum * btnH;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        /***  设置对应文字和图标  ***/
        btn.square = squares[i];
    }
    
    //设置footerView的高度
    self.yjw_height = self.subviews.lastObject.yjw_bottom;
    
    UITableView *tableView = (UITableView *)self.superview;
//    tableView.contentSize = CGSizeMake(0, self.yjw_buttom);//不靠谱
    tableView.tableFooterView = self;
    [tableView reloadData];//治疗底部多余的20空白，如果是后期设置的contentSize，底部会有多余的20
}

-(void)squareClick:(YJWSquareButton *)btn
{
    YJWMeSquare *square = btn.square;
    NSString *url = square.url;
    
    if ([url hasPrefix:@"http"]) {
        YJWWebViewController *webVC = [[YJWWebViewController alloc] init];
        webVC.navigationItem.title = btn.currentTitle;
        webVC.url = url;
        
        /*** SFSafariViewController   ***/
        /*
        SFSafariViewController *safari = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
        UITabBarController *tabVC = (UITabBarController *)self.window.rootViewController;
        UINavigationController *nav = tabVC.selectedViewController;
//        [nav pushViewController:safari animated:YES];
        [nav presentViewController:safari animated:YES completion:nil];
         */
        
        /***  获取当前view的nav  ***/
        UITabBarController *tabVC = (UITabBarController *)self.window.rootViewController;
        [tabVC.selectedViewController pushViewController:webVC animated:YES];
    }else if ([url hasPrefix:@"mod"]){
        NSLog(@"通过mod来做其它事情");
    }else{
        NSLog(@"不知道干啥去");
    }
}

@end
