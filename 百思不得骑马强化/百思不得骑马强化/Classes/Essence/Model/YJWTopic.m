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

@end
