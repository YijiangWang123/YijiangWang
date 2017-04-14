//
//  YJWTopicViewController.m
//  百思不得骑马强化
//
//  Created by YJW on 17/4/11.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWTopicViewController.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "YJWHttpSessionManager.h"

#import "YJWTopicCell.h"

@interface YJWTopicViewController ()

/** topicsArr   */
@property(nonatomic,strong) NSMutableArray<YJWTopic *> *topicsArr;
/** 加载除第一页之外的数据需要的参数   */
@property(nonatomic,strong) NSString *maxtime;
/** AFHTTPSessionManager   */
@property(nonatomic,strong) YJWHttpSessionManager *manager;

@end

@implementation YJWTopicViewController

//实现此方法，只是为了消除警告
-(YJWTopicType)type
{
    //默认显示全部内容
    return YJWTopicTypeAll;
}

static NSString *recommendID = @"recomend";

/***  懒加载 AFHTTPSessionManager  ***/
-(YJWHttpSessionManager *)manager
{
    if(!_manager){
        _manager = [YJWHttpSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = YJWCommonBackGroundColor;
    /***  设置内边距和初始化时内容偏移量  ***/
    self.tableView.contentInset = UIEdgeInsetsMake(99, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    /***  注册cell  ***/
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YJWTopicCell class]) bundle:nil] forCellReuseIdentifier:recommendID];
    //    self.tableView.rowHeight = 250;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setUpRefresh];
}

/***  添加刷新控件，刷新后再进行数据展示  ***/
-(void)setUpRefresh
{
    self.tableView.mj_header = [YJWHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [YJWFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark - 加载数据
/***  加载最上端数据  ***/
-(void)loadData
{
    //刷新数据之前，先停止其它加载活动
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject){
        /***  获取模型数组  ***/
        self.topicsArr = [YJWTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        /***  给maxtime赋值，以便可以加载第二页  ***/
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //加载数据后，再进行刷新表格
        [self.tableView reloadData];
        
        ///写到桌面
        //        [responseObject writeToFile:@"/Users/macbookpro/Desktop/newData.plist" atomically:YES];
        //        for (int i=0; i<self.topicsArr.count; i++) {
        //            YJWTopic *topic = self.topicsArr[i];
        //            if (topic.top_cmt.count) {
        //                NSLog(@"------%d------",i);
        //            }
        //        }
        
        //停止刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YJWLog(@"请求失败---%@",error);
        //停止刷新
        [self.tableView.mj_header endRefreshing];
    }];
}
/***  加载更多数据  ***/
-(void)loadMoreData
{
    //加载更多数据之前，先停止其它加载活动
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"maxtime"] = self.maxtime;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /***  获取模型数组，并加入到总数据源数组中  ***/
        NSArray *topics = [YJWTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topicsArr addObjectsFromArray:topics];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        [self.tableView reloadData];
        
        ///写到桌面
        //        [responseObject writeToFile:@"/Users/macbookpro/Desktop/moreData.plist" atomically:YES];
        //        for (int i=0; i<self.topicsArr.count; i++) {
        //            YJWTopic *topic = self.topicsArr[i];
        //            if (topic.top_cmt.count) {
        //                NSLog(@"------%d------",i);
        //            }
        //        }
        
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topicsArr[indexPath.row].cellHeight;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topicsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YJWTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendID];
    YJWTopic *topic = self.topicsArr[indexPath.row];
    
    cell.topic = topic;
    
    return cell;
}

@end
