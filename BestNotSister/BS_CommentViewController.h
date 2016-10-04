//
//  BS_CommentViewController.h
//  BestNotSister
//
//  Created by huhang on 16/5/13.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BS_Topic;
@interface BS_CommentViewController : UIViewController

/** 帖子模型 */
@property (nonatomic,strong)BS_Topic *topic;

@end
