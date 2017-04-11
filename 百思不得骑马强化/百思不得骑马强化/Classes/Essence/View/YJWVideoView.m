//
//  YJWVideoView.m
//  百思不得骑马强化
//
//  Created by YJW on 17/4/10.
//  Copyright © 2017年 yijiang. All rights reserved.
//

#import "YJWVideoView.h"
#import "YJWTopic.h"
#import <UIImageView+WebCache.h>

@interface YJWVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *videoImageV;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;

@end

@implementation YJWVideoView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

-(void)setTopic:(YJWTopic *)topic
{
    _topic = topic;
    [_videoImageV sd_setImageWithURL:[NSURL URLWithString:topic.image0]];
    _playcountLabel.text = [NSString stringWithFormat:@"%@次播放",topic.playcount];
    _videotimeLabel.text = topic.videotime;
}

@end
