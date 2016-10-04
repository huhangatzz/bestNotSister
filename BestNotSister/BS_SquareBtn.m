//
//  BS_SquareBtn.m
//  BestNotSister
//
//  Created by huhang on 16/5/18.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_SquareBtn.h"
#import "BS_Square.h"
#import "UIButton+WebCache.h"

@implementation BS_SquareBtn

#pragma mark 用于代码
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
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
    self.imageView.y = self.height * 0.15;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

- (void)setSquare:(BS_Square *)square{
    
    _square = square;
    
    //添加文字
    [self setTitle:square.name forState:UIControlStateNormal];
    //设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
    
}

@end