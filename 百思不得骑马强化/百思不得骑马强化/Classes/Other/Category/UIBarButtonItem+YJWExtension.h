//
//  UIBarButtonItem+YJWExtension.h
//  百思不得骑马强化
//
//  Created by YJW on 17/3/15.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YJWExtension)

+(instancetype)itemWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action;

@end
