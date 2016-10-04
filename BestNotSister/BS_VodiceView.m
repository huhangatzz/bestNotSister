//
//  BS_VodiceView.m
//  BestNotSister
//
//  Created by huhang on 16/3/31.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_VodiceView.h"
#import "BS_Topic.h"
#import "UIImageView+WebCache.h"

@interface BS_VodiceView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *lookNumLb;

@property (weak, nonatomic) IBOutlet UILabel *totalTimeLb;

@end

@implementation BS_VodiceView

- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playVodiceBtnAction)]];
    self.tag = 101;
}

- (IBAction)playVodiceBtnAction{
    
    NSLog(@"BS_VodiceView = %s",__func__);
    
    self.playBlock (self.playVoiceBtn);
}

- (void)setVodiceModel:(BS_Topic *)vodiceModel{

    _vodiceModel = vodiceModel;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:vodiceModel.large_imageUrl] placeholderImage:nil];
    
    //播放次数
    self.lookNumLb.text = [NSString stringWithFormat:@"%zd播放",vodiceModel.playcount];

    NSInteger minute = vodiceModel.videotime / 60;
    NSInteger second = vodiceModel.videotime % 60;
    
    self.totalTimeLb.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

@end
