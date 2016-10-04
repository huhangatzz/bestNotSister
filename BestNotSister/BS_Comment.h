//
//  BS_Comment.h
//  BestNotSister
//
//  Created by huhang on 16/5/12.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BS_User;
@interface BS_Comment : NSObject


/** id */
@property (nonatomic,copy)NSString *commentId;
/** 评论内容 */
@property (nonatomic,copy)NSString *content;
/** 点赞人数 */
@property (nonatomic,assign)NSInteger like_count;
/** 音频路径 */
@property (nonatomic,copy)NSString *voiceuri;
/** 音频文件时长 */
@property (nonatomic,assign)NSInteger voicetime;

/** 用户 */
@property (nonatomic,strong)BS_User *user;

/** cell高度 */
@property (nonatomic,assign)CGFloat cellHeight;

@end
