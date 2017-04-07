//
//  NSCalendar+YJWExtension.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/28.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "NSCalendar+YJWExtension.h"

@implementation NSCalendar (YJWExtension)

+(instancetype)yjw_calendar
{
    if ([self respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    }else{
        return [NSCalendar currentCalendar];
    }
}

@end
