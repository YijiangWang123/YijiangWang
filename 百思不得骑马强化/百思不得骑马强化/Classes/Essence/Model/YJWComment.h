//
//  YJWComment.h
//  百思不得骑马强化
//
//  Created by YJW on 17/3/29.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YJWUser;

@interface YJWComment : NSObject

/** 评论内容   */
@property(nonatomic,strong) NSString *content;
/** 用户   */
@property(nonatomic,strong) YJWUser *user;

@end
