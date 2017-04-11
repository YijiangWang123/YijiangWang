//
//  YJWExtensionConfig.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/30.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWExtensionConfig.h"

#import <MJExtension.h>
#import "YJWTopic.h"
#import "YJWComment.h"

@implementation YJWExtensionConfig

+(void)load
{
    [YJWTopic mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"top_cmt":[YJWComment class]};
    }];
    
    [YJWTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"top_cmt":@"top_cmt[0]"};
    }];
}

@end
