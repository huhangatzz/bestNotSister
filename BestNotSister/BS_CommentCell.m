//
//  BS_CommentCell.m
//  BestNotSister
//
//  Created by huhang on 16/5/16.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_CommentCell.h"
#import "BS_Comment.h"
#import "BS_User.h"

@interface BS_CommentCell ()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
/** 性别 */
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
/** 顶数量 */
@property (weak, nonatomic) IBOutlet UILabel *dingNumberlabel;
/** 评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
/** 评论按钮 */
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation BS_CommentCell

/* UIMenuController的使用
 
 1. Menu所处的View必须实现 – (BOOL)canBecomeFirstResponder, 且返回YES
 
 2. Menu所处的View必须实现 – (BOOL)canPerformAction:withSender, 并根据需求返回YES或NO
 
 3. 使Menu所处的View成为First Responder (becomeFirstResponder)
 
 4. 定位Menu (- setTargetRect:inView:)
 
 5. 展示Menu (- setMenuVisible:animated:)

*/

- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
}

- (void)awakeFromNib {
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setComment:(BS_Comment *)comment{

    _comment = comment;
    
    //头像
    [self.iconImageView addCircleImageOfUrlstr:comment.user.profile_image];
    //性别
    self.sexImageView.image = [comment.user.sex isEqualToString:@"m"] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    //昵称
    self.namelabel.text = comment.user.username;
    //顶数量
    self.dingNumberlabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    //评论内容
    self.commentLabel.text = comment.content;

    //音频声音
    if (comment.voiceuri.length > 0) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime] forState:UIControlStateNormal];
    }else{
        self.voiceButton.hidden = YES;
    }
}

- (void)setFrame:(CGRect)frame{
 
    frame.origin.x = CellMargin;
    frame.size.width -= 2 * CellMargin;

    [super setFrame:frame];
}

- (IBAction)voiceBtnAction:(id)sender {
    
}

@end
