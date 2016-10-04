//
//  BS_WordMessageModel.h
//  BestNotSister
//
//  Created by huhang on 16/3/25.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BS_Comment;
@interface BS_Topic : NSObject

/** 标签类型 */
@property (nonatomic,assign)BSTopicStateType type;
/*  */
@property (nonatomic,assign)BOOL isShowStopBtn;

#pragma mark ******************* 段子 *******************
/** 帖子id */
@property (nonatomic,copy)NSString *topicId;
/** 头像 */
@property (nonatomic,copy)NSString *profile_image;
/** 昵称 */
@property (nonatomic,copy)NSString *name;
/** 时间 */
@property (nonatomic,copy)NSString *create_time;
/** 内容 */
@property (nonatomic,copy)NSString *text;
/** 顶 */
@property (nonatomic,copy)NSString *ding;
/** 踩 */
@property (nonatomic,copy)NSString *cai;
/** 分享 */
@property (nonatomic,copy)NSString *repost;
/** 评论人数 */
@property (nonatomic,copy)NSString *comment;
/** 是否是新浪-v用户 */
@property (nonatomic,assign)BOOL is_vip;


#pragma mark ******************* 图片 *******************
/** 图片宽度 */
@property (nonatomic,assign)CGFloat width;
/** 图片高度 */
@property (nonatomic,assign)CGFloat height;
/** 小图片URL */
@property (nonatomic,copy)NSString *small_imageUrl;
/** 中图片URL */
@property (nonatomic,copy)NSString *middle_imageUrl;
/** 大图片URL */
@property (nonatomic,copy)NSString *large_imageUrl;
/** 是否是gif */
@property (nonatomic,assign)BOOL is_gif;


#pragma mark ******************* 声音 *******************
/** 声音时长 */
@property (nonatomic,assign)NSInteger voicetime;
/** 播放次数 */
@property (nonatomic,assign)NSInteger playcount;
/** 声音url */
@property (nonatomic,copy)NSString *voiceuri;


#pragma mark ******************* 视频 *******************
/** 播放时长 */
@property (nonatomic,assign)NSInteger videotime;
/** 播放地址 */
@property (nonatomic,copy)NSString *videouri;


#pragma mark ******************* 评论 *******************
/** 评论 */
@property (nonatomic,strong)BS_Comment *top_cmt;


#pragma mark ******************* 额外的辅助属性 *******************
/** 辅助高度 */
@property (nonatomic,assign,readonly)CGFloat cellHeight;
/** 图片的frame */
@property (nonatomic,assign)CGRect pictureFrame;
/** 是否太大 */
@property (nonatomic,assign,getter=isbigPicture)BOOL bigPicture;
/** 图片下载进度 */
@property (nonatomic,assign)CGFloat pictureProgress;
/** 声音的frame */
@property (nonatomic,assign)CGRect soundFrame;
/** 视频的frame */
@property (nonatomic,assign)CGRect vedioFrame;


@end
