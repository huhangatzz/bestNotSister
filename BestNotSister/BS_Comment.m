//
//  BS_Comment.m
//  BestNotSister
//
//  Created by huhang on 16/5/12.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_Comment.h"
#import "MJExtension.h"

@implementation BS_Comment

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"commentId":@"id"};
}

- (CGFloat)cellHeight{
    if (!_cellHeight) {
       
        CGFloat iconWH = 35;
        CGFloat margin = CellMargin;
        CGFloat dingW = 40;
        CGFloat maxW = SCREEN_WIDTH - (2 * margin + iconWH + dingW);
        CGSize  maxSize = CGSizeMake(maxW, MAXFLOAT);
        CGFloat contentH = [self.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil].size.height;
        
        _cellHeight = iconWH + margin * 3 + contentH;
    }
    
    return _cellHeight;
}

@end
