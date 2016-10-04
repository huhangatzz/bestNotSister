//
//  UIColor+Extension.h
//  mp_business
//
//  Created by huhang on 15/7/10.
//  Copyright (c) 2014年 huhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

//颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor*) colorWithHexString:(NSString*)color;
//颜色转换 可以设置透明度
+ (UIColor *) colorWithHexString:(NSString *)color alpha:(float)alpha;

@end
