//
//  BS_SoundViewCell.m
//  BestNotSister
//
//  Created by huhang on 16/3/31.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_SoundView.h"
#import "BS_Topic.h"
#import "UIImageView+WebCache.h"
#import "BS_TopicPictureController.h"
@interface BS_SoundView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *lookNumLb;
@property (weak, nonatomic) IBOutlet UILabel *playTotalLb;
@property (weak, nonatomic) IBOutlet UIButton *playSoundBtn;

@end

@implementation BS_SoundView

- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPictureAction)]];
    self.tag = 102;
}

//点击图片
- (void)clickPictureAction{
    BS_TopicPictureController *topicVC = [[BS_TopicPictureController alloc]init];
    topicVC.pictureModel = self.soundModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:topicVC animated:YES completion:nil];
}

//播放按钮
- (IBAction)playBtnAction {
    
    self.playBlock(self.playSoundBtn);
   
}

- (void)setSoundModel:(BS_Topic *)soundModel{
   
    _soundModel = soundModel;
    
    //背景图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:soundModel.large_imageUrl] placeholderImage:nil];
    
    //观看次数
    self.lookNumLb.text = [NSString stringWithFormat:@"%zd播放",soundModel.playcount];
    
    NSInteger minute = soundModel.voicetime / 60;
    NSInteger second = soundModel.voicetime % 60;
    //播放总时长
    self.playTotalLb.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

@end
