//
//  YJWHeader.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/25.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWHeader.h"

@implementation YJWHeader

-(void)prepare
{
    [super prepare];
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:@"refreshImg"];
    imageV.frame = CGRectMake(0, -270,[UIScreen mainScreen].bounds.size.width, 270);
    self.automaticallyChangeAlpha = YES;
    
    [self addSubview:imageV];
}

@end
