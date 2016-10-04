//
//  BS_RecommendTagsModel.h
//  BestNotSister
//
//  Created by huhang on 16/3/21.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BS_RecommendTagsModel : NSObject

/** 头像 */
@property (nonatomic,copy)NSString *image_list;
/** 标题 */
@property (nonatomic,copy)NSString *theme_name;
/** 总数 */
@property (nonatomic,assign)CGFloat sub_number;

@end
