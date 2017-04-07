//
//  YJWTitleButton.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/23.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWTitleButton.h"

@implementation YJWTitleButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted{};

@end
