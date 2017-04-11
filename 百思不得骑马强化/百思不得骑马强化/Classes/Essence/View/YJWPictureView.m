//
//  YJWPictureView.m
//  百思不得骑马强化
//
//  Created by YJW on 17/4/10.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWPictureView.h"
#import "YJWTopic.h"
#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>

@interface YJWPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *picImageV;
@property (weak, nonatomic) IBOutlet UIImageView *picGifImgV;
@property (weak, nonatomic) IBOutlet UIButton *picSeeBigBtn;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation YJWPictureView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
}

-(void)setTopic:(YJWTopic *)topic
{
    _topic = topic;
    /*
      此处还可以根据网络状态显示普通状态图或者高清图，由于发现不得姐所提供的图片一样，所以这里不作判断
     */
    [_picImageV sd_setImageWithURL:[NSURL URLWithString:topic.image0] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        //显示progressView
        _progressView.hidden = NO;
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        _progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //隐藏progreView
        _progressView.hidden = YES;
    }];
    
    //超大图处理
    if (topic.is_bigImage) {
        _picSeeBigBtn.hidden = NO;
        _picImageV.contentMode = UIViewContentModeTop;
        _picImageV.clipsToBounds = YES;
    }else{
        _picSeeBigBtn.hidden = YES;
        _picImageV.contentMode = UIViewContentModeScaleToFill;
        _picImageV.clipsToBounds = NO;
    }
    
    //处理git标识的一般方法
    /*
    if ([topic.image0.lowercaseString hasSuffix:@"gif"]) {
        self.picGifImgV.hidden = NO;
    }else{
        self.picGifImgV.hidden = YES;
    }
     */
    _picGifImgV.hidden = !topic.is_gif;
}

@end
