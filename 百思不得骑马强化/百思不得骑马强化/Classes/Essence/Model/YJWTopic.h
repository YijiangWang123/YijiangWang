//
//  YJWTopic.h
//  百思不得骑马强化
//
//  Created by YJW on 17/3/24.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,YJWTopicType){
    /***  图片类型  ***/
    YJWTopicTypeImage = 10,
    /***  段子类型  ***/
    YJWTopicTypeWord = 29,
    /***  音频类型  ***/
    YJWTopicTypeAudio = 31,
    /***  视频类型  ***/
    YJWTopicTypeVideo = 41
};

@interface YJWTopic : NSObject

/** 名称   */
@property(nonatomic,strong) NSString *name;
/** 头像   */
@property(nonatomic,strong) NSString *profile_image;
/** 时间   */
@property(nonatomic,strong) NSString *created_at;
/** text   */
@property(nonatomic,strong) NSString *text;

/** ding   */
@property(nonatomic,assign) NSInteger ding;
/** cai   */
@property(nonatomic,assign) NSInteger cai;
/** 转发数   */
@property(nonatomic,assign) NSInteger repost;
/** 评论数   */
@property(nonatomic,assign) NSInteger comment;

/** 最热评论   */
@property(nonatomic,strong) NSArray *top_cmt;

/** 类型   */
@property(nonatomic,assign) YJWTopicType type;

@end
