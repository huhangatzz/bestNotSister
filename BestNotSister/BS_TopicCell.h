//
//  BS_WordMessageCell.h
//  BestNotSister
//
//  Created by huhang on 16/3/25.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BS_Topic,BS_TopicCell,BS_VodiceView;

@protocol TopicCellDelegate <NSObject>

//点击播放按钮时
- (void)topicCellWithCell:(BS_TopicCell *)cell button:(UIButton *)button;

//点击cell时响应
@optional
- (void)topicCellWithCell:(BS_TopicCell *)cell clickBtn:(UIButton *)clickBtn;

@end
@interface BS_TopicCell : UITableViewCell

/** 段子模型 */
@property (nonatomic,strong)BS_Topic *topic;

/** 暂停按钮状态 */
@property (nonatomic,assign)BOOL showStopBtnSate;

@property (nonatomic,assign)id <TopicCellDelegate>delegate;

@end
