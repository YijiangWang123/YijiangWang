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

#import <Photos/Photos.h>//ios8开始推荐使用
//#import <AssetsLibrary/AssetsLibrary.h>//ios9开始废弃

@interface YJWSeeBigController ()<UIScrollViewDelegate>

/** 图片控件   */
@property(nonatomic,weak) UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation YJWSeeBigController

static NSString *YJWAssetCollectionTitle = @"你来咬我呀";

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
    //    PHAuthorizationStatusNotDetermined = 0,
    //    PHAuthorizationStatusRestricted,
    //    PHAuthorizationStatusDenied,
    //    PHAuthorizationStatusAuthorized
    
    //1.判断用户是否已经授权
    PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
    switch (authorizationStatus) {
        case PHAuthorizationStatusRestricted:
            [self showErrorWithText:@"系统权限问题，保存失败"];
            break;
        case PHAuthorizationStatusDenied:
            [self showErrorWithText:@"设置->隐私->相册中更改权限"];
            break;
        case PHAuthorizationStatusAuthorized:
            //保存图片
            [self saveImage];
            break;
        case PHAuthorizationStatusNotDetermined:
            //弹框要求用户授权
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    //保存图片
                    [self saveImage];
                }else{
                    [self showErrorWithText:@"没有权限访问相册"];
                }
            }];
            break;
    }
}

-(void)saveImage{
    //1.首先将图片保存到相机胶卷中
    //2.创建一个相册
    //3.将刚刚添加到相机胶卷中的图片添加到创建的相册中
    
    ///PHAsset的标识, 利用这个标识可以找到对应的PHAsset对象(图片对象)
    __block NSString *assetsWithLocalIdentifier = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //1.首先将图片保存到相机胶卷中
        assetsWithLocalIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imgV.image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            [self showErrorWithText:@"保存图片到相机胶卷中失败"];
            return;
        }
        
        //2.获得相册
        PHAssetCollection *createdAssetCollection = [self createdAssetCollection];
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            
            //获取图片
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetsWithLocalIdentifier] options:nil].lastObject;
            
            ///将图片添加到相册中的请求
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
            ///添加图片到相册
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error){
            if (success == NO) {
                [self showErrorWithText:@"添加图片到自定义相册中失败"];
            }else{
                [self showSuccessWithText:@"添加图片到自定义相册中成功"];
            }
        }];
    }];
}

///这里需要获取曾经创建过的相册，如果没有对应的相册就重新创建一个
-(PHAssetCollection *)createdAssetCollection
{
    ///获取所有相册
    PHFetchResult *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    ///遍历获得和指定相册名相同的相册
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:YJWAssetCollectionTitle]) {
            return assetCollection;
        }
    }
    
    ///如果没有找对对应的相册，就重新创建一个
    ///PHAssetCollection的标识，利用这个这个标识可以找到对应的PHAssetCollection对象（相册对象）
    __block NSString *assetCollectionsWithLocalIdentifier = nil;
    ///错误信息
    NSError *error = nil;
    ///创建相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetCollectionsWithLocalIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:YJWAssetCollectionTitle].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    //提示是否成功
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"创建相册失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"创建相册成功"];
    }
    //获取相册并返回
    PHAssetCollection *assetCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionsWithLocalIdentifier] options:nil].lastObject;
    
    return assetCollection;
}

-(void)showSuccessWithText:(NSString *)text{
    [SVProgressHUD showSuccessWithStatus:text];
}
-(void)showErrorWithText:(NSString *)text{
    [SVProgressHUD showErrorWithStatus:text];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - <UIScrollViewDelegate>
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imgV;
}

#pragma mark - 在使用<Photos/Photos.h>之前保存图片用以下方法

@end
