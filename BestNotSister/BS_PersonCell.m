//
//  BS_PersonCell.m
//  BestNotSister
//
//  Created by huhang on 16/5/17.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_PersonCell.h"

@implementation BS_PersonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = imageView;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.imageView.image != nil) {
        
        self.imageView.width = 30;
        self.imageView.height = self.imageView.width;
        self.imageView.centerY = self.contentView.height * 0.5;
        
        self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + CellMargin;
    }
}

@end
