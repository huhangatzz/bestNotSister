//
//  BS_User.h
//  BestNotSister
//
//  Created by huhang on 16/5/12.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BS_User : NSObject

/** 名字 */
@property (nonatomic,copy)NSString *username;
/** 头像 */
@property (nonatomic,copy)NSString *profile_image;
/** 性别 */
@property (nonatomic,copy)NSString *sex;

@end
