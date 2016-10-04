//
//  BS_TopicPictureView.m
//  BestNotSister
//
//  Created by huhang on 16/3/28.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_TopicPictureView.h"
#import "BS_Topic.h"
#import "UIImageView+WebCache.h"
#import "BS_ProgressView.h"
#import "BS_TopicPictureController.h"
@interface BS_TopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigBtn;
@property (weak, nonatomic) IBOutlet BS_ProgressView *progressView;

@end

@implementation BS_TopicPictureView

#pragma mark 初始化方法

/*
 -(void)awakeFromNib;从字面上理解，就是从nib文件中唤醒对象，完成对每一个对象的实例化或与nib文件的关联。
 当使用一个controller控制多个nib文件时，awakeFromNib方法会被多次调用。因此，当不使用awakeFromNib方法来完成nib对象的初始化时，需要注意此方法的多次调用对其他nib文件造成的影响。
 */
#pragma mark 唤醒nib文件中的对象
- (void)awakeFromNib{
    
    //不需要自动调整
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showAllPicture)]];
}

#pragma mark 赋值
-(void)setPictureModel:(BS_Topic *)pictureModel{

    _pictureModel = pictureModel;
    
    [self.progressView setProgress:pictureModel.pictureProgress animated:NO];
    
    NSURL *imgUrl = [NSURL URLWithString:pictureModel.large_imageUrl];
    
    //下载图片进度
    [self.imageView sd_setImageWithURL:imgUrl placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressView.hidden = NO;
        
        pictureModel.pictureProgress = 1.0 * receivedSize / expectedSize;
        
        //设置进度
        [self.progressView setProgress:pictureModel.pictureProgress animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        //图片需要从顶部显示,不然后直接缩放会从中间显示
        if (pictureModel.isbigPicture){
            //大图片就需要作处理
            CGRect rect = pictureModel.pictureFrame;
            self.imageView.image = [image imageWithGraphicsContext:rect];
        }
    
    }];
    
    //是否显示点击查看全图
    self.seeBigBtn.hidden = !pictureModel.isbigPicture;
    //是否显示gif图标
    self.gifImageView.hidden = !pictureModel.is_gif;
}

#pragma mark 点击图片
- (void)showAllPicture{
    
    BS_TopicPictureController *topicVC = [[BS_TopicPictureController alloc]init];
    topicVC.pictureModel = self.pictureModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:topicVC animated:YES completion:nil];
}

@end
