//
//  YJWLoginRegisterTextField.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/16.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWLoginRegisterTextField.h"
#import <objc/runtime.h>

@implementation YJWLoginRegisterTextField

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    /***  设置指示器为白色  ***/
    self.tintColor = [UIColor whiteColor];
    
    /***  设置站位文字为浅白色  ***/
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
    
    /***  通过运行时获取变量名称，然后通过KVC设置  ***/
//    [self setValue:[UIColor redColor] forKeyPath:@"placeholderLabel.textColor"];
    //通过运行时获取变量名
//    unsigned int outCount;
//    Ivar *varList = class_copyIvarList([UITextField class], &outCount);
//    for (int i=0; i<outCount; i++) {
//        Ivar var = varList[i];
//        YJWLog(@"%s",ivar_getName(var));
//    }
    
    /***  设置文字颜色为白色  ***/
    self.textColor = [UIColor whiteColor];
    
    /***  选中时占位文字为白色,取消选中时恢复灰白色  一种方法用addTarget实现，另一种方法用通知实现，还可以通过delegate实现***/
    [self addTarget:self action:@selector(editingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editingDidEnd:) name:UITextFieldTextDidEndEditingNotification object:self];
}

-(void)editingDidBegin
{
    [self setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.textColor"];
}

-(void)editingDidEnd:(NSNotification *)notification
{
    [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
}

/***  移除通知  ***/
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
