//
//  UIBarButtonItem+BSBarButton.h
//  BestNotSister
//
//  Created by huhang on 16/3/16.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BSBarButton)

+ (instancetype)itemWithImage:(UIImage *)image heightImage:(UIImage *)heightImage target:(id)target action:(SEL)action;

@end
