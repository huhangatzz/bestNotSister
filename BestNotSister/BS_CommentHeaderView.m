//
//  BS_CommentHeaderView.m
//  BestNotSister
//
//  Created by huhang on 16/5/13.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_CommentHeaderView.h"

@interface BS_CommentHeaderView ()

@property (nonatomic,strong)UILabel *label;

@end

@implementation BS_CommentHeaderView

+ (instancetype)commentHeaderViewWithTableView:(UITableView *)tableView{
 
    BS_CommentHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (!headerView) {
        headerView = [[BS_CommentHeaderView alloc]initWithReuseIdentifier:@"headerView"];
    }
    
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc] init];
        label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        label.textColor = [UIColor colorWithHexString:FONT_COLOR_ACCTOUN_NOTE];
        label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat labelX = CellMargin;
    CGFloat labelY = 0;
    CGFloat labelW = self.width;
    CGFloat labelH = self.height;
    
    self.label.frame = CGRectMake(labelX, labelY, labelW, labelH);
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.label.text = title;
}

@end
