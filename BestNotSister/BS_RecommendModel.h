//
//  BS_RecommendModel.h
//  BestNotSister
//
//  Created by huhang on 16/3/19.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BS_RecommendModel : NSObject

/** id */
@property (nonatomic,assign)NSInteger recommendId;
/** 名字 */
@property (nonatomic,copy)NSString *name;
/** 总数 */
@property (nonatomic,copy)NSString *count;

/** 右侧模型数组 */
@property (nonatomic,strong)NSMutableArray *users;
/** 总数 */
@property (nonatomic,assign)NSInteger total;
/** 当前页码 */
@property (nonatomic,assign)NSInteger currentage;


@end
