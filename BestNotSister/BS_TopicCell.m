//
//  BS_WordMessageCell.m
//  BestNotSister
//
//  Created by huhang on 16/3/25.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_TopicCell.h"

#import "BS_TopicPictureView.h"
#import "BS_SoundView.h"
#import "BS_VodiceView.h"
#import "BS_Comment.h"
#import "BS_Topic.h"
#import "BS_User.h"

@interface BS_TopicCell()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
/** 创建时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLb;
/** 关注按钮 */
@property (weak, nonatomic) IBOutlet UIButton *focusBtn;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
/** 转发 */
@property (weak, nonatomic) IBOutlet UIButton *repostBtn;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
/** 新浪加v */
@property (weak, nonatomic) IBOutlet UIImageView *sina_v;
/** 内容 */
@property (weak, nonatomic) IBOutlet UILabel *contentTextLb;
/** 图片视图 */
@property (strong, nonatomic) BS_TopicPictureView *pictureView;
/** 声音视图 */
@property (strong, nonatomic) BS_SoundView *soundView;
/** 视频视图 */
@property (strong, nonatomic) BS_VodiceView *vodiceView;

/** 最新评论视图 */
@property (weak, nonatomic) IBOutlet UIView *topComView;
/** 最新评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *topComConentLb;

@end

@implementation BS_TopicCell

//创建图片视图
- (BS_TopicPictureView *)pictureView{

    if (!_pictureView) {
        BS_TopicPictureView *pictureView = [BS_TopicPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

//创建声音视图
- (BS_SoundView *)soundView{

    if (!_soundView) {
        BS_SoundView *soundView = [BS_SoundView viewFromXib];
        [self.contentView addSubview:soundView];
        _soundView = soundView;
    }
    return _soundView;
}

//创建视频视图
- (BS_VodiceView *)vodiceView{

    if (!_vodiceView) {
        BS_VodiceView *vodiceView = [BS_VodiceView viewFromXib];
        [self.contentView addSubview:vodiceView];
        _vodiceView = vodiceView;
    }
    return _vodiceView;
}

- (void)awakeFromNib{
    [super awakeFromNib];
//    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark 模型set方法
- (void)setTopic:(BS_Topic *)topic{

    _topic = topic;
    
    //顶部视图
    
    //是否新浪v用户
    self.sina_v.hidden = !topic.is_vip;
    //头像
    [self.profileImage addCircleImageOfUrlstr:topic.profile_image];
    //名字
    self.nameLb.text = topic.name;
    //创建时间
    self.createTimeLb.text = topic.create_time;
    //文本内容
    self.contentTextLb.text = topic.text;
    
    //根据模型的类型添加对应内容到cell中间
    if (topic.type == BSTopicStateTypePicture) {//图片帖子
        self.pictureView.hidden = NO;
        self.pictureView.pictureModel = topic;
        self.pictureView.frame = topic.pictureFrame;
        
        self.soundView.hidden = YES;
        self.vodiceView.hidden = YES;
    }else if (topic.type == BSTopicStateTypeSound){//声音帖子
        self.soundView.hidden = NO;
        self.soundView.soundModel = topic;
        [self playWithVodiceSounderViewState:BSTopicStateTypeSound];
        self.soundView.frame = topic.soundFrame;
        
        self.pictureView.hidden = YES;
        self.vodiceView.hidden = YES;
    }else if (topic.type == BSTopicStateTypeVedio){//视频帖子
        self.vodiceView.hidden = NO;
        self.vodiceView.vodiceModel = topic;
        [self playWithVodiceSounderViewState:BSTopicStateTypeVedio];
        self.vodiceView.frame = topic.vedioFrame;
        
        self.pictureView.hidden = YES;
        self.soundView.hidden = YES;
    }else{//全部
        self.pictureView.hidden = YES;
        self.soundView.hidden = YES;
        self.vodiceView.hidden = YES;
    }
    
    if (topic.top_cmt) {
        self.topComView.hidden = NO;
        self.topComConentLb.text = [NSString stringWithFormat:@"%@ : %@",topic.top_cmt.user.username,topic.top_cmt.content];
    }else{
        self.topComView.hidden = YES;
    }
    
    //底部视图
    [self setupButtonTitle:self.dingBtn count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiBtn count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostBtn count:topic.repost placeholder:@"转发"];
    [self setupButtonTitle:self.commentBtn count:topic.comment placeholder:@"评论"];
}

- (void)setShowStopBtnSate:(BOOL)showStopBtnSate{
 
    _showStopBtnSate = showStopBtnSate;
    
    if (_topic.type == BSTopicStateTypeVedio) {
        self.vodiceView.playVoiceBtn.hidden = showStopBtnSate;
    }

}

#pragma mark 点击播放按钮
- (void)playWithVodiceSounderViewState:(BSTopicStateType)type{

    __weak typeof(self) weakSelf = self;
    if (type == BSTopicStateTypeSound) {//音频
        self.soundView.playBlock = ^ (UIButton *playSoundBtn){
            if ([weakSelf.delegate respondsToSelector:@selector(topicCellWithCell:button:)]) {
                [weakSelf.delegate topicCellWithCell:weakSelf button:playSoundBtn];
            }
        };
    }else if (type == BSTopicStateTypeVedio){//视频
        
        self.vodiceView.playBlock = ^ (UIButton *playVoiceBtn){
            if ([weakSelf.delegate respondsToSelector:@selector(topicCellWithCell:button:)]) {
                NSLog(@"cell中点击播放按钮 = %s",__func__);
                [weakSelf.delegate topicCellWithCell:weakSelf button:playVoiceBtn];
            }
        };
    }
}

#pragma mark 底部视图
- (void)setupButtonTitle:(UIButton *)button count:(NSString *)count placeholder:(NSString *)placeholder{

    NSInteger peopleCount = [count integerValue];
    if (peopleCount > 10000) {
        placeholder = [NSString stringWithFormat:@"%0.1f万人",peopleCount / 10000.0];
    }else{
        placeholder = count;
    }

    [button setTitle:placeholder forState:UIControlStateNormal];
}

#pragma mark 修改frame(一定要注意把父类的方法加上)
- (void)setFrame:(CGRect)frame{

    frame.origin.x = CellMargin; //让x往右移动10,宽度减少20
    frame.size.width -= 2 * CellMargin;
    frame.origin.y += CellMargin;//让y往下移动10,高度减少10
    frame.size.height = self.topic.cellHeight - CellMargin;
    [super setFrame:frame];
}

#pragma mark 点击关注按钮
- (IBAction)concernAction:(id)sender {
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
    [sheet showInView:self.window];
}

- (IBAction)clickCellAction:(id)sender {
    
    NSLog(@"%s",__func__);
    if ([self.delegate respondsToSelector:@selector(topicCellWithCell:clickBtn:)]) {
        [self.delegate topicCellWithCell:self clickBtn:sender];
    }
}

@end
