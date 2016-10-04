//
//  BS_PlaceholderTextView.m
//  BestNotSister
//
//  Created by huhang on 16/5/18.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_PlaceholderTextView.h"

/*
 setNeedsDisplay会调用自动调用drawRect方法，这样可以拿到UIGraphicsGetCurrentContext，就可以画画了。
 setNeedsLayout会默认调用layoutSubViews，就可以处理子视图中的一些数据。
 综上所诉，setNeedsDisplay方便绘图，而layoutSubViews方便出来数据。
*/

@interface BS_PlaceholderTextView ()

@property (nonatomic,strong)UILabel *placeholderLabel;

@end

@implementation BS_PlaceholderTextView

- (UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        UILabel *placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = 4;
        placeholderLabel.y = 7;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    
    return _placeholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
 
    if (self = [super initWithFrame:frame]) {
        // 垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        // 默认字体
        self.font = [UIFont systemFontOfSize:15];
        // 默认的占位文字颜色
        self.placeholderColor = [UIColor grayColor];
        // 监听文字改变
        [BSNotfCenter addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc{
    [BSNotfCenter removeObserver:self];
}

- (void)textChange{
    //当有文字时self.hasText为1,没有时为0
    self.placeholderLabel.hidden = self.hasText;
}

//更新文字尺寸
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
}

#pragma mark 重写set方法
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    
    [self textChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    
    [self textChange];
}

@end
