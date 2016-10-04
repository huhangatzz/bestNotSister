//
//  BS_TagTextField.m
//  BestNotSister
//
//  Created by huhang on 16/5/19.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_TagTextField.h"

@implementation BS_TagTextField

- (instancetype)initWithFrame:(CGRect)frame{
 
    if (self = [super initWithFrame:frame]) {
        self.placeholder = @"多个标签用逗号或者换行隔开";
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.height = 25;
    }
    return self;
}

- (void)deleteBackward{

    !self.deleBlock ? : self.deleBlock();
    
    [super deleteBackward];
}

@end
