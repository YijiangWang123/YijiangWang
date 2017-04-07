//
//  YJWVideoController.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/23.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWVideoController.h"

@interface YJWVideoController ()

@end

@implementation YJWVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    YJWFunc;
    self.tableView.backgroundColor = YJWRandomColor;
    
    /***  设置内边距和初始化时内容偏移量  ***/
    self.tableView.contentInset = UIEdgeInsetsMake(98, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *videoID = @"video";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:videoID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:videoID];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%@--%zd",[self class],indexPath.row];
    
    return cell;
}
@end
