//
//  BS_CommentCell.h
//  BestNotSister
//
//  Created by huhang on 16/5/16.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BS_Comment;
@interface BS_CommentCell : UITableViewCell

/** 评论数据模型 */
@property (nonatomic,strong)BS_Comment *comment;

@end
