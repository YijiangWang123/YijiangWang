//
//  YJWEssenceViewController.m
//  百思不得骑马强化
//
//  Created by YJW on 16/10/11.
//  Copyright © 2016年 yijiang. All rights reserved.
//

#import "YJWEssenceViewController.h"
#import "YJWTitleButton.h"

#import "YJWRecommendController.h"
#import "YJWVideoController.h"
#import "YJWPictureController.h"
#import "YJWWordController.h"
#import "YJWPaiHangController.h"
#import "YJWSocietyController.h"
#import "YJWBeautyController.h"
#import "YJWGameController.h"
#import "YJWNetHotController.h"

@interface YJWEssenceViewController ()<UIScrollViewDelegate>

/** 记录选中的按钮   */
@property(nonatomic,strong) YJWTitleButton *selectedBtn;
/** 标题指示器   */
@property(nonatomic,weak) UIView *titleIndicator;
/** 记录按钮   */
@property(nonatomic,weak) YJWTitleButton *recordBtn;
/** scrollView   */
@property(nonatomic,weak) UIScrollView *scrollView;
/** titleView   */
@property(nonatomic,weak) UIView *titleView;

@end

@implementation YJWEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self setUpChildViewControllers];
    
    [self setUpScrollView];
    
    [self setUpTitleView];
}

/***  初始化子控制器  ***/
-(void)setUpChildViewControllers
{
    YJWRecommendController *allVC = [[YJWRecommendController alloc] init];
    [self addChildViewController:allVC];
    
    YJWVideoController *videoVC = [[YJWVideoController alloc] init];
    [self addChildViewController:videoVC];
    
    YJWPictureController *picVC = [[YJWPictureController alloc] init];
    [self addChildViewController:picVC];
    
    YJWWordController *wordVC = [[YJWWordController alloc] init];
    [self addChildViewController:wordVC];
    
    YJWPaiHangController *paihangVC = [[YJWPaiHangController alloc] init];
    [self addChildViewController:paihangVC];
    
    YJWSocietyController *societyVC = [[YJWSocietyController alloc] init];
    [self addChildViewController:societyVC];
    
    YJWBeautyController *beautyVC = [[YJWBeautyController alloc] init];
    [self addChildViewController:beautyVC];
    
    YJWGameController *gameVC = [[YJWGameController alloc] init];
    [self addChildViewController:gameVC];
    
    YJWNetHotController *nethotVC = [[YJWNetHotController alloc] init];
    [self addChildViewController:nethotVC];
}

/***  添加标题视图  ***/
-(void)setUpTitleView
{
    /***  添加滚动视图  ***/
    UIScrollView *titleView = [[UIScrollView alloc] init];
    titleView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    titleView.yjw_x = 0;
    titleView.yjw_y = 64;
    titleView.yjw_width = self.view.yjw_width;
    titleView.yjw_height = 35;
    titleView.showsHorizontalScrollIndicator = NO;

    /***  添加标题按钮  ***/
    NSArray *titles = @[@"推荐",@"视频",@"图片",@"段子",@"排行",@"社会",@"美女",@"游戏",@"网红"];
    NSUInteger titleCount = titles.count;
    CGFloat btnW = self.view.yjw_width / 5;
    CGFloat btnH = titleView.yjw_height;
    
    //设置标题滚动视图contentSize
    titleView.contentSize = CGSizeMake(btnW * titleCount, 0);
    
    //创建按钮
    for (int i=0; i<titleCount; i++) {
        YJWTitleButton *button = [YJWTitleButton buttonWithType:UIButtonTypeCustom];
        //给button绑定tag
        button.tag = i;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        button.frame = CGRectMake(btnW * i, 0, btnW, btnH);
    }
    
    //获取第一个button，以便设置指示器的颜色，和进入应用程序时选中第一个标题按钮
    YJWTitleButton *firstTitleBtn = [titleView subviews].firstObject;
    
    /***  添加底部指示器  ***/
    UIView *titleIndicator = [[UIView alloc] init];
    titleIndicator.backgroundColor = [firstTitleBtn titleColorForState:UIControlStateSelected];;
    [titleView addSubview:titleIndicator];
    titleIndicator.yjw_height = 2;
    titleIndicator.yjw_y = titleView.yjw_height - titleIndicator.yjw_height;
    self.titleIndicator = titleIndicator;
    
    /***  初始化时，选中第一个按钮，并显示指示器  ***/
    [firstTitleBtn.titleLabel sizeToFit];
    self.titleIndicator.yjw_width = firstTitleBtn.titleLabel.yjw_width;
    self.titleIndicator.yjw_centerX = firstTitleBtn.yjw_centerX;
    
    firstTitleBtn.selected = YES;
    self.recordBtn = firstTitleBtn;
    
    /***  初始化时，展示第一页内容  ***/
    [self createChildController];
}

-(void)titleClick:(YJWTitleButton *)btn
{
    self.recordBtn.selected = NO;
    btn.selected = YES;
    self.recordBtn = btn;
    //实现指示器动画
    [UIView animateWithDuration:0.25 animations:^{
        self.titleIndicator.yjw_width = btn.titleLabel.yjw_width;
        self.titleIndicator.yjw_centerX = btn.yjw_centerX;
    }];
    
    /***  点击标题按钮，切换到对应的内容  ***/
    CGPoint point = self.scrollView.contentOffset;
    point.x = self.scrollView.yjw_width * btn.tag;
    //点击按钮，先切换到对应的内容部分，然后再加载内容展示
    [self.scrollView setContentOffset:point animated:YES];
}

/***  添加ScrollView  ***/
-(void)setUpScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = YJWCommonBackGroundColor;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    scrollView.frame = self.view.frame;
    /***  设置分页  ***/
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;
    
    //禁止自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //子控制器的个数
    NSUInteger childControllerCount = self.childViewControllers.count;
    
    /***  会一下子创建所有子控制器，解决方案，在代理方法中创建并将其view添加到scrollView中，实现懒加载  ***/
//    for (int i=0; i<childControllerCount; i++) {
//        UITableView *tableView = (UITableView *)self.childViewControllers[i].view;
//        [scrollView addSubview:tableView];
//        
//        /***  设置tableView的y和高  ***/
//        tableView.yjw_y = 0;
//        tableView.yjw_height = scrollView.yjw_height;
//        /***  设置每一个tableView的位置  ***/
//        tableView.yjw_x = i * scrollView.yjw_width;
//        //设置tableView的内边距
//        tableView.contentInset = UIEdgeInsetsMake(98, 0, 49, 0);
//        /***  设置滑动条的内边距  ***/
//        tableView.scrollIndicatorInsets = tableView.contentInset;
//    }
    
    /***  设置scrollView的contentSize  ***/
    scrollView.contentSize = CGSizeMake(scrollView.yjw_width * childControllerCount, 0);
}

/***  setNav  ***/
-(void)setNav
{
    self.view.backgroundColor = YJWCommonBackGroundColor;
    
    /***  标题  ***/
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main"]];
    
    /***  左侧按钮  ***/
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(tagBtnClick)];
}

/***  点击左侧按钮  ***/
-(void)tagBtnClick
{
    YJWFunc;
    
    UIViewController *test = [[UIViewController alloc] init];
    test.view.backgroundColor = YJWRandomColor;
    [test.navigationController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:test animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
/***  called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating  ***/
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self createChildController];
}

/***  人为拖拽时候调用这个方法  ***/
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.yjw_width;
    YJWTitleButton *button = self.titleView.subviews[index];
    [self titleClick:button];
 
    [self createChildController];
}

/***  添加子控制器的view  ***/
-(void)createChildController
{
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.yjw_width;
    UITableViewController *tableVC = self.childViewControllers[index];
    
    /***  多次执行addSubview只会添加一次，如果想要以后不再添加，有三种解决方案  ***/
    //1.
    //if(tableVC.viewLoaded) return;
    UITableView *tableView = tableVC.tableView;
    //2.
    //if (tableView.superview) return;
    //3.
    if(tableView.window) return;
    
    [self.scrollView addSubview:tableView];
    
//    tableView.yjw_x = index * self.scrollView.yjw_width;
//    tableView.yjw_y = 0;
//    tableView.yjw_height = self.scrollView.yjw_height;
    tableView.frame = self.scrollView.bounds;
}

@end
