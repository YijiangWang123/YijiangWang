//
//  UIView+YJWExtension.m
//  百思不得骑马强化
//
//  Created by YJW on 16/10/12.
//  Copyright © 2016年 yijiang. All rights reserved.
//

#import "UIView+YJWExtension.h"

@implementation UIView (YJWExtension)

/***  yjw_x  ***/
-(void)setYjw_x:(CGFloat)yjw_x
{
    CGRect frame = self.frame;
    frame.origin.x = yjw_x;
    self.frame = frame;
}
-(CGFloat)yjw_x
{
    return self.frame.origin.x;
}

/***  yjw_y  ***/
-(void)setYjw_y:(CGFloat)yjw_y
{
    CGRect frame = self.frame;
    frame.origin.y = yjw_y;
    self.frame = frame;
}
-(CGFloat)yjw_y
{
    return  self.frame.origin.y;
}

/***  yjw_width  ***/
-(void)setYjw_width:(CGFloat)yjw_width
{
    CGRect frame = self.frame;
    frame.size.width = yjw_width;
    self.frame = frame;
}
-(CGFloat)yjw_width
{
    return self.frame.size.width;
}

/***  yjw_height  ***/
-(void)setYjw_height:(CGFloat)yjw_height
{
    CGRect frame = self.frame;
    frame.size.height = yjw_height;
    self.frame = frame;
}
-(CGFloat)yjw_height
{
    return self.frame.size.height;
}

/***  yjw_size  ***/
-(void)setYjw_size:(CGSize)yjw_size
{
    CGRect frame = self.frame;
    frame.size = yjw_size;
    self.frame = frame;
}
-(CGSize)yjw_size
{
    return self.frame.size;
}

/***  yjw_centerX  ***/
-(void)setYjw_centerX:(CGFloat)yjw_centerX
{
    CGPoint point = self.center;
    point.x = yjw_centerX;
    self.center = point;
}
-(CGFloat)yjw_centerX
{
    return self.center.x;
}

/***  yjw_centerY  ***/
-(void)setYjw_centerY:(CGFloat)yjw_centerY
{
    CGPoint point = self.center;
    point.y = yjw_centerY;
    self.center = point;
}
-(CGFloat)yjw_centerY
{
    return self.center.y;
}

/***  yjw_right  ***/
-(void)setYjw_right:(CGFloat)yjw_right
{
    self.yjw_x = yjw_right - self.yjw_width;
}
-(CGFloat)yjw_right
{
    return self.yjw_x + self.yjw_width;
}

/***  yjw_buttom  ***/
-(void)setYjw_bottom:(CGFloat)yjw_bottom
{
    self.yjw_x = yjw_bottom - self.yjw_width;
}
-(CGFloat)yjw_bottom
{
    return CGRectGetMaxY(self.frame);
}

@end
