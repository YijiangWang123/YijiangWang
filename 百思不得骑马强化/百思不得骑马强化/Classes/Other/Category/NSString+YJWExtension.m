//
//  NSString+YJWExtension.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/22.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "NSString+YJWExtension.h"

@implementation NSString (YJWExtension)

//-(CGFloat)yjw_getFileSize
//{
//    CGFloat total = 0;
//
//    NSFileManager *manager = [NSFileManager defaultManager];
//    /***  获取文件属性  ***/
//    NSDictionary *attr = [manager attributesOfItemAtPath:self error:nil];
//    /***  判断是文件夹还是文件  ***/
//    if ([attr.fileType isEqualToString:NSFileTypeDirectory]) {
//        /***  获取所有子路径  ***/
//        NSArray *fileArr = [manager subpathsOfDirectoryAtPath:self error:nil];
//        /***  遍历所有子路径  ***/
//        for (NSString *path in fileArr) {
//            NSString *fullPath = [self stringByAppendingPathComponent:path];
//            total += [manager attributesOfItemAtPath:fullPath error:nil].fileSize;
//        }
//    }else{
//        /***  直接返回文件大小  ***/
//        total = attr.fileSize;
//    }
//    
//    return total;
//}

-(CGFloat)yjw_getFileSize
{
    CGFloat total = 0;
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDictionary *attr = [manager attributesOfItemAtPath:self error:nil];
    /***  判断是文件还是文件夹  ***/
    if ([attr.fileType isEqualToString:NSFileTypeRegular]) {
        total = attr.fileSize;
    }else{
        NSEnumerator *fileEnum = [manager enumeratorAtPath:self];
        for (NSString *file in fileEnum) {
            NSString *fullPath = [self stringByAppendingPathComponent:file];
            total += [manager attributesOfItemAtPath:fullPath error:nil].fileSize;
        }
    }
    
    return total;
}

@end
