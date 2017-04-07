//
//  NSDate+YJWExtension.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/28.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "NSDate+YJWExtension.h"

@implementation NSDate (YJWExtension)

static NSCalendar *calendar_;

+(void)initialize
{
    [super initialize];
    
    calendar_ = [NSCalendar yjw_calendar];
}

-(BOOL)isThisYear
{
    /***  获取当前所在年  ***/
    NSInteger currentYear = [calendar_ component:NSCalendarUnitYear fromDate:[NSDate date]];
    /***  获取selfYear  ***/
    NSInteger selfYear = [calendar_ component:NSCalendarUnitYear fromDate:self];
    
    return (currentYear == selfYear);
}

#warning iOS8 之前使用这方法
-(BOOL)isToday
{
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *selfCmp = [calendar_ components:unit fromDate:self];
    NSDateComponents *nowCmp = [calendar_ components:unit fromDate:[NSDate date]];
    
    return (selfCmp.year == nowCmp.year) && (selfCmp.month == nowCmp.month) && (selfCmp.day == nowCmp.day);
}

#warning iOS8 之前使用这方法
-(BOOL)isYesterday
{
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *selfCmp = [calendar_ components:unit fromDate:self];
    NSDateComponents *nowCmp = [calendar_ components:unit fromDate:[NSDate date]];
    
    return (selfCmp.year == nowCmp.year) && (selfCmp.month == nowCmp.month) && (selfCmp.day == nowCmp.day - 1);
}

@end
