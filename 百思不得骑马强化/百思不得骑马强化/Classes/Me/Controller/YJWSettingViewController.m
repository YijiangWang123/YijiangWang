//
//  YJWSettingViewController.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/15.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWSettingViewController.h"
#import "YJWClearCacheCell.h"
#import "YJWSettingCell.h"
#import "YJWSettingOtherCell.h"

@interface YJWSettingViewController ()

@end

@implementation YJWSettingViewController

-(instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

static NSString *clearCacheID = @"clearCache";
static NSString *settingID = @"setting";
static NSString *settingOtherID = @"settingOther";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    self.tableView.backgroundColor = YJWCommonBackGroundColor;
    
    /***  注册cell  ***/
    [self.tableView registerClass:[YJWClearCacheCell class] forCellReuseIdentifier:clearCacheID];
    [self.tableView registerClass:[YJWSettingCell class] forCellReuseIdentifier:settingID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YJWSettingOtherCell class]) bundle:nil] forCellReuseIdentifier:settingOtherID];
}

#pragma mark - 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [tableView dequeueReusableCellWithIdentifier:clearCacheID];
        }else{
            YJWSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:settingID];
            if (indexPath.row == 1) {
                cell.textLabel.text = @"关于我们";
            }else if (indexPath.row == 2){
                cell.textLabel.text = @"当前版本";
            }else if(indexPath.row == 3){
                cell.textLabel.text = @"给我们评价";
            }else{
                cell.textLabel.text = @"版本更新";
            }
            return cell;
        }
    }else if (indexPath.section == 1){
        YJWSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:settingID];
        cell.textLabel.text = @"最新活动";
        return cell;
    }else{
        YJWSettingOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:settingOtherID];
        return cell;
    }
}

@end
