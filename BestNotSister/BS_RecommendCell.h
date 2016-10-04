//
//  BS_RecommendCell.h
//  BestNotSister
//
//  Created by huhang on 16/3/19.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BS_RecommendModel;

@interface BS_RecommendCell : UITableViewCell

/** 数据模型 */
@property (nonatomic,strong)BS_RecommendModel *recommendModel;

@end
