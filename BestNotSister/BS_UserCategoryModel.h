//
//  BS_UserCategoryModel.h
//  BestNotSister
//
//  Created by huhang on 16/3/21.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BS_UserCategoryModel : NSObject

/** 头像 */
@property (nonatomic,copy)NSString *header;
/** 粉丝数 */
@property (nonatomic,assign)NSInteger fans_count;
/** 昵称 */
@property (nonatomic,copy)NSString *screen_name;

@end
