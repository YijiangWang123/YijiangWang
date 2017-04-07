//
//  YJWSquareButton.h
//  百思不得骑马强化
//
//  Created by YJW on 17/3/20.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJWMeSquare;

@interface YJWSquareButton : UIButton

/** 为按钮绑定模型，方便以后点击时候获取对应URL   */
@property(nonatomic,strong) YJWMeSquare *square;

@end
