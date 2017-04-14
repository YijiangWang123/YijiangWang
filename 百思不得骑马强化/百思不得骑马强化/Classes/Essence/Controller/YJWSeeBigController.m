//
//  YJWSeeBigController.m
//  百思不得骑马强化
//
//  Created by YJW on 17/4/14.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWSeeBigController.h"
#import <UIImageView+WebCache.h>
#import "YJWTopic.h"
#import <SVProgressHUD.h>

#import <Photos/Photos.h>

@interface YJWSeeBigController ()<UIScrollViewDelegate>

/** 图片控件   */
@property(nonatomic,weak) UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation YJWSeeBigController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建一个scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = self.view.bounds;
    [self.view insertSubview:scrollView atIndex:0];
    
    //创建图片控件，然后加到scrollView中
    UIImageView *imageV = [[UIImageView alloc] init];
    [imageV sd_setImageWithURL:[NSURL URLWithString:self.topic.image1] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //如果图片不为空，让保存按钮改为可用状态
        if (image != nil) {
            self.saveBtn.enabled = YES;
        }
    }];
    [scrollView addSubview:imageV];
    self.imgV = imageV;
    
    //设置imgV的frame
    imageV.yjw_x = 0;
    imageV.yjw_width = scrollView.yjw_width;
    imageV.yjw_height = self.topic.height * imageV.yjw_width / self.topic.width;
    
    //比较imageV的高度和scrollView的高度
    if (imageV.yjw_height >= scrollView.yjw_height) {
        imageV.yjw_y = 0;
        //设置scrollView的内容大小
        scrollView.contentSize = CGSizeMake(0, imageV.yjw_height);
    }else{
        imageV.center = scrollView.center;
    }
    
    //缩放比例
    CGFloat scale = imageV.yjw_height / scrollView.yjw_height;
    if (scale > 1) {
        scrollView.maximumZoomScale = scale;
    }
}

///保存图片
- (IBAction)save:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.imgV.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"图片保存成功"];
    }
}

#pragma mark - <UIScrollViewDelegate>
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imgV;
}

@end
