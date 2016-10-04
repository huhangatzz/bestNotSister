//
//  BS_UserCategoryCell.m
//  BestNotSister
//
//  Created by huhang on 16/3/21.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_UserCategoryCell.h"
#import "BS_UserCategoryModel.h"

@interface BS_UserCategoryCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *screenNmae;
@property (weak, nonatomic) IBOutlet UILabel *fansCount;

@end

@implementation BS_UserCategoryCell

- (void)awakeFromNib {
   
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setUserModel:(BS_UserCategoryModel *)userModel{

    //头像
    [self.headerImageView addCircleImageOfUrlstr:userModel.header];
    //昵称
    self.screenNmae.text = userModel.screen_name;
    //粉丝人数
    self.fansCount.text = [NSString stringWithFormat:@"%ld人关注",(long)userModel.fans_count];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
