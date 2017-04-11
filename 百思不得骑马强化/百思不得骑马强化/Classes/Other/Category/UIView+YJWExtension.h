//
//  UIView+YJWExtension.h
//  百思不得骑马强化
//
//  Created by YJW on 16/10/12.
//  Copyright © 2016年 yijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YJWExtension)

/** 宽   */
@property(nonatomic,assign) CGFloat yjw_width;
/** 高   */
@property(nonatomic,assign) CGFloat yjw_height;
/** x   */
@property(nonatomic,assign) CGFloat yjw_x;
/** y   */
@property(nonatomic,assign) CGFloat yjw_y;
/** 尺寸   */
@property(nonatomic,assign) CGSize yjw_size;
/** 中心x   */
@property(nonatomic,assign) CGFloat yjw_centerX;
/** 中心y   */
@property(nonatomic,assign) CGFloat yjw_centerY;
/** 最右边   */
@property(nonatomic,assign) CGFloat yjw_right;
/** 最下边   */
@property(nonatomic,assign) CGFloat yjw_bottom;


/** 从xib创建view */
+(instancetype)yjw_viewFromXib;

@end
