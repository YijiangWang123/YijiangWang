//
//  YJWBeautyController.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/23.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWBeautyController.h"

@interface YJWBeautyController ()

@end

@implementation YJWBeautyController

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
    
    static NSString *beautyID = @"beauty";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:beautyID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:beautyID];
    }

    
    cell.textLabel.text = [NSString stringWithFormat:@"%@--%zd",[self class],indexPath.row];
    
    return cell;
}

@end
