//
//  UIImage+Extension.h
//  TinyBook
//
//  Created by huhang on 16/4/22.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

//对图片按点拉伸,保证图片不失真
+ (UIImage *)imageWithStrecthableName:(NSString *)imgstr;
//对图片按比例拉伸,防止失真
- (UIImage *)imageWithGraphicsContext:(CGRect)rect;
//把图片变成圆形
- (UIImage *)circleImage;

@end
