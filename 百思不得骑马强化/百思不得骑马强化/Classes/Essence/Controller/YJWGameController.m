//
//  YJWGameController.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/23.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWGameController.h"

@interface YJWGameController ()

@end

@implementation YJWGameController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = YJWRandomColor;
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
    
    static NSString *gameID = @"game";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:gameID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:gameID];
    }

    
    cell.textLabel.text = [NSString stringWithFormat:@"%@--%zd",[self class],indexPath.row];
    
    return cell;
}

@end
