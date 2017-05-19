//
//  YJWTopicCell.m
//  百思不得骑马强化
//
//  Created by YJW on 17/3/25.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWTopicCell.h"
#import <UIImageView+WebCache.h>

#import "YJWTopic.h"
#import "YJWComment.h"
#import "YJWUser.h"

#import "YJWVideoView.h"
#import "YJWAudioView.h"
#import "YJWPictureView.h"

@interface YJWTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profile_imageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *created_atLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_Label;

@property (weak, nonatomic) IBOutlet UIView *hotView;
@property (weak, nonatomic) IBOutlet UILabel *hotTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commmentBtn;

/** pic   */
@property(nonatomic,weak) YJWPictureView *pictureView;
/** video   */
@property(nonatomic,weak) YJWVideoView *videoView;
/** audio   */
@property(nonatomic,weak) YJWAudioView *audioView;

@end

@implementation YJWTopicCell

//懒加载
-(YJWPictureView *)pictureView
{
    if(!_pictureView){
        YJWPictureView *pictureView = [YJWPictureView yjw_viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
-(YJWAudioView *)audioView
{
    if(!_audioView){
        YJWAudioView *audioView = [YJWAudioView yjw_viewFromXib];
        [self.contentView addSubview:audioView];
        _audioView = audioView;
    }
    return _audioView;
}
-(YJWVideoView *)videoView
{
    if(!_videoView){
        YJWVideoView *videoView = [YJWVideoView yjw_viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

-(void)setTopic:(YJWTopic *)topic
{
    _topic = topic;
    
    [self.profile_imageV sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;

//    self.created_atLabel.text = topic.created_at;
    self.text_Label.text = topic.text;
    
    [self setUpBtn:self.dingBtn number:topic.ding placeHolder:@"顶"];
    [self setUpBtn:self.caiBtn number:topic.cai placeHolder:@"踩"];
    [self setUpBtn:self.shareBtn number:topic.repost placeHolder:@"转发"];
    [self setUpBtn:self.commmentBtn number:topic.comment placeHolder:@"评论"];
    
    YJWComment *comment = topic.top_cmt;
    /***  判断最热评论是否要隐藏  ***/
    if (comment) {
        self.hotView.hidden = NO;
        self.hotTextLabel.text = [NSString stringWithFormat:@"%@:%@",comment.user.username,comment.content];
    }else{
        self.hotView.hidden = YES;
    }

    /***  判断帖子类型  ***/
    if (topic.type == YJWTopicTypeImage) {
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.audioView.hidden = YES;
        
        self.pictureView.frame = topic.contentF;
        self.pictureView.topic = topic;
    }else if (topic.type == YJWTopicTypeWord){
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.audioView.hidden = YES;
    }else if (topic.type == YJWTopicTypeAudio){
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.audioView.hidden = NO;
        
        self.audioView.frame = topic.contentF;
        self.audioView.topic = topic;
    }else if (topic.type == YJWTopicTypeVideo){
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.audioView.hidden = YES;
        
        self.videoView.frame = topic.contentF;
        self.videoView.topic = topic;
    }
}

-(void)setUpBtn:(UIButton *)button number:(NSInteger)number placeHolder:(NSString *)placeHolder
{
    NSString *text = nil;
    if (number>=pow(10, 4)) {
        text = [NSString stringWithFormat:@"%.1f万",number / 10000.0];
    }else if (number>0){
        text = [NSString stringWithFormat:@"%ld",number];
    }else{
        text = placeHolder;
    }
    [button setTitle:text forState:UIControlStateNormal];
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.y += YJWMargin;
    frame.size.height -= YJWMargin;
    [super setFrame:frame];
}

/***  显示弹框  ***/
- (IBAction)moreClick:(id)sender {
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showLoginRegister];
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showLoginRegister];
    }]];
    
    [self.window.rootViewController presentViewController:sheet animated:YES completion:nil];
}

/***  展示注册登录界面  ***/
-(void)showLoginRegister
{
    YJWLoginRegisterViewController *loginRegister = [[YJWLoginRegisterViewController alloc] init];
    [self.window.rootViewController presentViewController:loginRegister animated:YES completion:nil];
}

@end
