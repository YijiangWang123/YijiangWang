//
//  YJWTopic.h
//  百思不得骑马强化
//
//  Created by YJW on 17/3/24.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YJWComment;

typedef NS_ENUM(NSInteger,YJWTopicType){
    /***  所有类型  ***/
    YJWTopicTypeAll = 1,
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
/** 高度   */
@property(nonatomic,assign) CGFloat height;
/** 宽度   */
@property(nonatomic,assign) CGFloat width;

/** ding   */
@property(nonatomic,assign) NSInteger ding;
/** cai   */
@property(nonatomic,assign) NSInteger cai;
/** 转发数   */
@property(nonatomic,assign) NSInteger repost;
/** 评论数   */
@property(nonatomic,assign) NSInteger comment;

/** 最热评论   */
@property(nonatomic,strong) YJWComment *top_cmt;

/** playcount   */
@property(nonatomic,strong) NSString *playcount;
/** videotime   */
@property(nonatomic,assign) NSInteger videotime;
/** voicetime   */
@property(nonatomic,assign) NSInteger voicetime;
/** image   */
@property(nonatomic,strong) NSString *image0;
/** image   */
@property(nonatomic,strong) NSString *image1;
/** image   */
@property(nonatomic,strong) NSString *image_small;

/** 类型   */
@property(nonatomic,assign) YJWTopicType type;
/** 是否是gif   */
@property(nonatomic,assign) BOOL is_gif;

/** 额外增加的属性，方便开发   */
@property(nonatomic,assign) CGFloat cellHeight;
/** 设置控件的frame   */
@property(nonatomic,assign) CGRect contentF;
/** 标记是否为超长图片   */
@property(nonatomic,assign,getter=is_bigImage) BOOL bigImage;
@end
