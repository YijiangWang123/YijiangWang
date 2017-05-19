//
//  YJWTopic.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/24.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWTopic.h"
#import <MJExtension.h>
#import "YJWComment.h"
#import "YJWUser.h"

@implementation YJWTopic

/***  指明数组 top_cmt 内的对象为 YJWComment 类型 ***/
//+(NSDictionary *)mj_objectClassInArray
//{
//    return @{@"top_cmt" : [YJWComment class]};
//}

/***  全局变量  ***/
static NSDateFormatter *formatter_;
static NSCalendar *calendar_;

+(void)initialize
{
    formatter_ = [[NSDateFormatter alloc] init];
    calendar_ = [NSCalendar yjw_calendar];
}

-(NSString *)created_at
{
    /***  获取帖子创建日期  ***/
    formatter_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAt = [formatter_ dateFromString:_created_at];
    
    /***  今年  ***/
    if (createdAt.isThisYear) {
        /***  今天  ***/
        if ([calendar_ isDateInToday:createdAt]) {
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute;
            NSDateComponents *cmp = [calendar_ components:unit fromDate:createdAt toDate:[NSDate date] options:0];
            /***  大于1小时  ***/
            if (cmp.hour>1) {
                return [NSString stringWithFormat:@"%zd小时前",cmp.hour];
            /***  大小1分钟  ***/
            }else if (cmp.minute>1){
                return [NSString stringWithFormat:@"%zd分钟前",cmp.minute];
            /***  小于1分钟  ***/
            }else{
                return @"刚刚";
            }
            /***  昨天  ***/
        }else if([createdAt isYesterday]){ //[calendar_ isDateInYesterday:createdAt]
            formatter_.dateFormat = @"昨天 HH:mm";
            return [formatter_ stringFromDate:createdAt];
            /***  其它  ***/
        }else{
            formatter_.dateFormat = @"MM月dd日 HH:mm";
            return [formatter_ stringFromDate:createdAt];
        }
    /***  非今年  ***/
    }else{
        formatter_.dateFormat = @"yyyy-MM-dd HH:mm";
        return [formatter_ stringFromDate:createdAt];
    }
}

-(CGFloat)cellHeight
{
    //1.头像高度
    _cellHeight = 50;
    
    //2.文字高度
    CGFloat YJWMargin = 10;
    CGFloat textWidth = [UIScreen mainScreen].bounds.size.width - 2 * YJWMargin;
    CGSize textSize = CGSizeMake(textWidth, MAXFLOAT);
    CGFloat textHeight = [_text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
    _cellHeight += (textHeight + 34);
    
    //3.如果不是段子，就需要加入其它控件
    if (_type != YJWTopicTypeWord) {
        CGFloat contentHeight = textWidth * _height / _width;
        
        //如果是超长图片，就显示部分
        if (contentHeight >= [UIScreen mainScreen].bounds.size.height) {
            contentHeight = 200;
            self.bigImage = YES;
        }
        
        self.contentF = CGRectMake(YJWMargin, _cellHeight, textWidth, contentHeight);
        
        _cellHeight += contentHeight + YJWMargin * 2;
    }
    
    //4.热评
    if (_top_cmt) {
        //热评标题和三段间距
        _cellHeight += 15;
        //热评内容高度
        NSString *top_cmtContent = [NSString stringWithFormat:@"%@:%@",_top_cmt.user.username,_top_cmt.content];
        CGFloat top_cmtHeight = [top_cmtContent boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.height;
        _cellHeight += top_cmtHeight;
    }
    
    //5.底部工具条
    _cellHeight += 35;
    
    return _cellHeight;
}

@end
