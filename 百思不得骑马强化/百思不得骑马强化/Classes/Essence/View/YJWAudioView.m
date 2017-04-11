//
//  YJWAudioView.m
//  百思不得骑马强化
//
//  Created by YJW on 17/4/10.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWAudioView.h"
#import "YJWTopic.h"
#import <UIImageView+WebCache.h>

@interface YJWAudioView ()

@property (weak, nonatomic) IBOutlet UIImageView *audioImageV;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;

@end

@implementation YJWAudioView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

-(void)setTopic:(YJWTopic *)topic
{
    _topic = topic;
    [_audioImageV sd_setImageWithURL:[NSURL URLWithString:topic.image0]];
    _playcountLabel.text = [NSString stringWithFormat:@"%@次播放",topic.playcount];
    
    //设置时长
    NSInteger min = topic.voicetime / 60;
    NSInteger sec = topic.voicetime % 60;
    _voicetimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",min,sec];
}

@end
