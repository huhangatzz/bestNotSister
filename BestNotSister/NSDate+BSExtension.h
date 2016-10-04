//
//  NSDate+BSExtension.h
//  BestNotSister
//
//  Created by huhang on 16/3/28.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BSExtension)

/** 
 *比较pastTime和self时间差值
 */
- (NSDateComponents *)compareTime;

/**
 *是否今年
 */
- (BOOL)isThisYear;

/**
 *是否今天
 */
- (BOOL)isToday;

/**
 *是否昨天
 */
- (BOOL)isYesterday;


@end
