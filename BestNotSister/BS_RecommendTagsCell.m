//
//  BS_RecommendTagsCell.m
//  BestNotSister
//
//  Created by huhang on 16/3/21.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_RecommendTagsCell.h"
#import "BS_RecommendTagsModel.h"

@interface BS_RecommendTagsCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageList;
@property (weak, nonatomic) IBOutlet UILabel *themeName;
@property (weak, nonatomic) IBOutlet UILabel *subNumber;

@end

@implementation BS_RecommendTagsCell

- (void)setTagsModel:(BS_RecommendTagsModel *)tagsModel{

    _tagsModel = tagsModel;
    
    [self.imageList addCircleImageOfUrlstr:tagsModel.image_list];
    self.themeName.text = tagsModel.theme_name;
    if (tagsModel.sub_number < 10000) {
        self.subNumber.text = [NSString stringWithFormat:@"%zd人订阅",tagsModel.sub_number];
    }else{
        self.subNumber.text = [NSString stringWithFormat:@"%.1f万人订阅",tagsModel.sub_number];
    }
}

- (void)setFrame:(CGRect)frame{

    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

@end
