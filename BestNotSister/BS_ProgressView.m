//
//  BS_ProgressView.m
//  BestNotSister
//
//  Created by huhang on 16/3/29.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_ProgressView.h"

@implementation BS_ProgressView

- (void)awakeFromNib{

    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated{

    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
