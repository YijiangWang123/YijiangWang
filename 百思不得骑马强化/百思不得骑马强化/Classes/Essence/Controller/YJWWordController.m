//
//  YJWWordController.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/23.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWWordController.h"
#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN
@interface YJWWordController ()


@end

@implementation YJWWordController

-(YJWTopicType)type
{
    [self numberWithProblems:4 distance:210];
    return YJWTopicTypeWord;
}

-(NSInteger)numberWithProblems:(NSInteger)n distance:(NSInteger)m{
  
    NSInteger total = 240;
    NSInteger solvedProblem = 0;
    
    for (int i=1; i<=n; i++) {
        if (total >= (i*(i+1)*5/2+m)) {
            solvedProblem += 1;
        }
    }
    NSLog(@"%zd",solvedProblem);
    
    return solvedProblem;
}

@end
NS_ASSUME_NONNULL_END
