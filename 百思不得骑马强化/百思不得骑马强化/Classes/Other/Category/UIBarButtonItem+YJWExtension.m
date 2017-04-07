//
//  UIBarButtonItem+YJWExtension.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/15.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "UIBarButtonItem+YJWExtension.h"

@implementation UIBarButtonItem (YJWExtension)

+(instancetype)itemWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
