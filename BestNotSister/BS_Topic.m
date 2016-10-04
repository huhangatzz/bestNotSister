//
//  BS_WordMessageModel.m
//  BestNotSister
//
//  Created by huhang on 16/3/25.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_Topic.h"
#import "MJExtension.h"
#import "BS_Comment.h"
#import "BS_User.h"


@implementation BS_Topic
{
    CGFloat _cellHeight;
}

//替换名字
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"small_imageUrl":@"image0",
             @"middle_imageUrl":@"image2",
             @"large_imageUrl":@"image1",
             @"topicId":@"id",
             @"top_cmt" : @"top_cmt[0]"};
}

//替换数组
+ (NSDictionary *)objectClassInArray{
    return @{};
}

- (NSString *)create_time{

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createTime = [formatter dateFromString:_create_time];
    
    if ([createTime isThisYear]) { //今年
        
        if ([createTime isToday]) { //今天
            
            if ([createTime compareTime].hour >= 1) { //几小时前
                
                return [NSString stringWithFormat:@"%zd小时前",[createTime compareTime].hour];
                
            }else if ([createTime compareTime].minute > 1){ //几分钟前
                
                return [NSString stringWithFormat:@"%zd分钟前",[createTime compareTime].minute];
                
            }else{
                
                return @"刚刚";
            }
            
        }else if ([createTime isYesterday]){ //昨天
            
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return [formatter stringFromDate:createTime];
            
        }else{ //其他
            
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:createTime];
            
        }
        
    }else{ //不是今年
        
        return _create_time;
    }
}

- (CGFloat)cellHeight{

    if (!_cellHeight) {
        
        CGFloat margin = CellMargin;
        CGFloat totalIconH = 50;
        CGFloat toolBarH = 44;
        CGFloat downH = CellMargin;//高度整体下移了10
        
        //文字内容的高度(要注意字体大小)
        CGSize maxSize = CGSizeMake(SCREEN_WIDTH - 4 * margin, MAXFLOAT);
        CGFloat textH = [_text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil].size.height;
       
        //显示段子时cell高度
        _cellHeight = totalIconH + margin * 2 + textH + downH;
        
        //根据段子类型来计算cell的高度
        CGFloat topicX = 10;
        CGFloat topicY = totalIconH + margin * 2 + textH;
        CGFloat topicW = maxSize.width;
        if (self.type == BSTopicStateTypePicture) {//图片帖子
            //按比例计算图片高度
            CGFloat pictureH = topicW * (self.height / self.width);
            //如果图片高度过长
            if (pictureH >= 320 && !self.is_gif) {
                pictureH = 320;
                self.bigPicture = YES;//是大图
            }else{//是小图
                self.bigPicture = NO;
            }
            //图片的frame
            self.pictureFrame = CGRectMake(topicX, topicY, topicW, pictureH);
            //添加图片后cell高度
            _cellHeight =  topicY + pictureH + margin + downH;
            
        }else if (self.type == BSTopicStateTypeSound){ //声音帖子
            //按比例计算声音帖子的高度
            CGFloat soundH = topicW * (self.height / self.width);
            //计算声音帖子的frame
            self.soundFrame = CGRectMake(topicX, topicY, topicW, soundH);
            //添加声音帖子后cell高度
            _cellHeight = topicY + soundH + margin + downH;
            
        }else if (self.type == BSTopicStateTypeVedio){ //视频帖子
            //按比例计算视频帖子的高度
            CGFloat vedioH = topicW * (self.height / self.width);
            //计算视频帖子的frame
            self.vedioFrame = CGRectMake(topicX, topicY, topicW, vedioH);
            //添加视频帖子后cell高度
            _cellHeight = topicY + vedioH + margin + downH;//视频高度
        }
 
        if (self.top_cmt > 0) {
          
            NSString *content = [NSString stringWithFormat:@"%@ : %@",_top_cmt.user.username,_top_cmt.content];
            CGFloat commentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
            //添加评论后cell高度
            _cellHeight += commentH + downH + 20;
        }
        
        _cellHeight += toolBarH;
    }
    return _cellHeight;
}

@end
