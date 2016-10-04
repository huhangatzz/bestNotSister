//
//  UIBarButtonItem+BSBarButton.m
//  BestNotSister
//
//  Created by huhang on 16/3/16.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "UIBarButtonItem+BSBarButton.h"

@implementation UIBarButtonItem (BSBarButton)

+ (instancetype)itemWithImage:(UIImage *)image heightImage:(UIImage *)heightImage target:(id)target action:(SEL)action{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:heightImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.size = button.currentImage.size;
    return [[self alloc]initWithCustomView:button];
}

@end
