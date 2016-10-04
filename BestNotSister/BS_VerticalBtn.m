//
//  BS_QuickLoginBtn.m
//  BestNotSister
//
//  Created by huhang on 16/3/23.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_VerticalBtn.h"

@implementation BS_VerticalBtn

#pragma mark 用于代码
- (instancetype)initWithFrame:(CGRect)frame{
 
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark 用于xib中
- (void)awakeFromNib{

    [self setup];
}

#pragma mark 调整布局
- (void)layoutSubviews{

    //一定要记住调父类的方法
    [super layoutSubviews];

    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
