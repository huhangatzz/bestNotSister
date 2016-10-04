//
//  BS_RecommendCell.m
//  BestNotSister
//
//  Created by huhang on 16/3/19.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_RecommendCell.h"
#import "BS_RecommendModel.h"

@interface BS_RecommendCell()

@property (weak, nonatomic) IBOutlet UIView *selectIndex;

@end

@implementation BS_RecommendCell

- (void)awakeFromNib {
    
    self.backgroundColor = BSRGBColor(244, 244, 244);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.selectIndex.backgroundColor = BSRGBColor(219, 21, 26);
}

//只要涉及到frame,都在这个方法中设置
- (void)layoutSubviews{

    [super layoutSubviews];
    //y下降2
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

//设置数据
- (void)setRecommendModel:(BS_RecommendModel *)recommendModel{

    self.textLabel.text = recommendModel.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectIndex.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectIndex.backgroundColor : BSRGBColor(78, 78, 78);
   
}

@end
