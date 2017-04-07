//
//  YJWClearCacheCell.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/22.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWClearCacheCell.h"
#import <SVProgressHUD.h>

/***  获取cache路径  ***/
#define cachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject

@implementation YJWClearCacheCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        /***  计算缓存时候cell的样式  ***/
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [indicator startAnimating];
        self.accessoryView = indicator;
        self.textLabel.text = @"清除缓存（正在计算缓存大小。。。）";
        //禁止点击
        self.userInteractionEnabled = NO;
        
        /***  使用弱引用：当还没有计算出文件大小时，用户点击返回键，setting控制器就会被销毁，此时应当不再去刷新cell内容  ***/
        __weak typeof(self) weakSelf = self;
        
        /***  在子线程获取文件大小  ***/
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            /***  计算大小，比较耗时  ***/
            CGFloat total = cachePath.yjw_getFileSize;
            NSString *cacheText = nil;
            
            //如果cell已经被销毁，就直接返回
            if (weakSelf == nil) return ;
            
            if (total > pow(10, 9)) {
                cacheText = [NSString stringWithFormat:@"清除缓存（已使用%.2fGB）",total / pow(10,9)];
            }else if(total > pow(10, 6)){
                cacheText = [NSString stringWithFormat:@"清除缓存（已使用%.2fMB）",total / pow(10,6)];
            }else if (total > pow(10, 3)){
                cacheText = [NSString stringWithFormat:@"清除缓存（已使用%.2fKB）",total / pow(10,3)];
            }else{
                cacheText = [NSString stringWithFormat:@"清除缓存（已使用%.2fKB）",total];
            }

            /***  回主线程显示  ***/
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.textLabel.text = cacheText;
                //删除原有accessoryView，重新设置
                weakSelf.accessoryView = nil;
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                //恢复点击
                weakSelf.userInteractionEnabled = YES;
                //添加单击手势
                [weakSelf addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:weakSelf action:@selector(clearCacheClick)]];
            });
        });
    }
    
    return self;
}

-(void)clearCacheClick
{
    if([self.textLabel.text isEqualToString:@"清除缓存（0KB）"]){
        [SVProgressHUD showInfoWithStatus:@"暂无缓存"];
        [SVProgressHUD dismissWithDelay:0.5];
    }else{
        /***  添加蒙板  ***/
        [SVProgressHUD showWithStatus:@"正在清除缓存"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        
        //在子线程，清除缓存
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSFileManager *manager = [NSFileManager defaultManager];
            [manager removeItemAtPath:cachePath error:nil];
            [manager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
            
            //回主线程，重新显示cell
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                self.textLabel.text = @"清除缓存（0KB）";
            });
        });
    }
}

/***  每次当cell进入视野时，会调用次方法。在这个方法里面解决的问题：当用户上拉，下拉时，动画消失的问题  ***/
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)self.accessoryView;
    [indicatorView startAnimating];
}

@end
