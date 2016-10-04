//
//  UIImage+Extension.m
//  TinyBook
//
//  Created by huhang on 16/4/22.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)imageWithStrecthableName:(NSString *)imgstr{

    UIImage *tempImage = [UIImage imageNamed:imgstr];
    return [tempImage stretchableImageWithLeftCapWidth:tempImage.size.width * 0.5 topCapHeight:tempImage.size.height * 0.5];
}

- (UIImage *)imageWithGraphicsContext:(CGRect)rect{

    //获取图片上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0);
    //将下载的image绘制到上下文
    CGFloat width = rect.size.width;
    CGFloat height = width * self.size.height / self.size.width;
    [self drawInRect:CGRectMake(0, 0, width, height)];
    //获取图片
    UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    return getImage;
}

- (UIImage *)circleImage{
 
    //NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    //获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    //裁剪
    CGContextClip(ctx);
    //将图片画上去
    [self drawInRect:rect];
    
    //获取图片
    UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    
    return getImage;
}


@end
