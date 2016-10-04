//
//  BS_TagButton.m
//  BestNotSister
//
//  Created by huhang on 16/5/19.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_TagButton.h"

@implementation BS_TagButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor colorWithHexString:DEFAULT_BACKGROUND_COLOR];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    //设置宽
    self.width += 3 * TagMargin;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.x = TagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + TagMargin;
}


@end
