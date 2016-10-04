//
//  NSDate+BSExtension.m
//  BestNotSister
//
//  Created by huhang on 16/3/28.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "NSDate+BSExtension.h"

@implementation NSDate (BSExtension)

- (NSDateComponents *)compareTime{

    //获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

- (BOOL)isThisYear{

    //获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //获取当前年份
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    //获取判断年份
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}

- (BOOL)isToday{

    //日期格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [formatter stringFromDate:[NSDate date]];
    NSString *selfString = [formatter stringFromDate:self];
    
    return [nowString isEqualToString:selfString];
}

- (BOOL)isYesterday{

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *comp = [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
    
    return comp.year == 0 && comp.month == 0 && comp.day == 1;
}

@end
