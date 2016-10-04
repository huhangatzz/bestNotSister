//
//  BS_CommentViewController.m
//  BestNotSister
//
//  Created by huhang on 16/5/13.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_CommentViewController.h"
#import "BS_Comment.h"
#import "BS_CommentCell.h"
#import "BS_CommentHeaderView.h"
#import "BS_Topic.h"
#import "BS_TopicCell.h"
#import "MJRefresh.h"
#import "ZFPlayer.h"

@interface BS_CommentViewController ()<UITableViewDataSource,UITableViewDelegate,TopicCellDelegate>

//输入框底部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;
//评论表格视图
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;

//最热评论数组
@property (nonatomic,strong)NSMutableArray *hotComments;
//最近评论数组
@property (nonatomic,strong)NSMutableArray *lastestComments;

@property (nonatomic,strong)BS_Comment *save_top_cmt;

@property (nonatomic,assign)NSInteger page;

@property (nonatomic,assign)NSInteger totalCount;

@property (nonatomic,strong)UIMenuController *menu;

/** 暂停按钮 */
@property (nonatomic,strong)UIButton *stopButton;

/** 视频播放视图 */
@property (nonatomic,strong)ZFPlayerView *playerView;

@end

@implementation BS_CommentViewController

static NSString * const commentCell = @"commentCell";

- (ZFPlayerView *)playerView{
    
    if (!_playerView) {
        _playerView = [ZFPlayerView sharedPlayerView];
    }
    return _playerView;
}

- (UIMenuController *)menu{
    if (!_menu) {
      UIMenuController *menu = [UIMenuController sharedMenuController];
      _menu = menu;
    }
    return _menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //改变位置
    [self changeTextFieldLocation];
    
    //调整tableView
    [self adjuestTableView];
   
    //添加cell
    [self addTheTopicCell];
    
    //添加刷新
    [self startRefresh];
    
    [self.commentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BS_CommentCell class]) bundle:nil] forCellReuseIdentifier:commentCell];
    [self.commentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"topicCell"];
    
    //显示暂停按钮
    [BSNotfCenter addObserver:self selector:@selector(showStopButton) name:@"backButtonAction" object:nil];
}

#pragma mark 显示暂停按钮
- (void)showStopButton{
    self.stopButton.hidden = NO;
}

- (void)adjuestTableView{
    self.commentTableView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    self.commentTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.commentTableView.scrollIndicatorInsets = self.commentTableView.contentInset;
    self.commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.commentTableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark 刷新数据
- (void)startRefresh{
 
    self.commentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshheader)];
    [self.commentTableView.mj_header beginRefreshing];
    
    self.commentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    self.commentTableView.mj_footer.hidden = YES;
}

- (void)refreshheader{

    NSString *topicId = self.topic.topicId;
    [BS_HttpTools topicCommentId:topicId success:^(id responseObject) {
        
        //最热评论
        self.hotComments = [BS_Comment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        //最新评论
        self.lastestComments = [BS_Comment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        //结束头部刷新
        [self.commentTableView.mj_header endRefreshing];
        
        [self.commentTableView reloadData];
        
        //控制footer状态
        self.totalCount = [responseObject[@"total"] integerValue];
        if (self.lastestComments.count >= self.totalCount) {
            self.commentTableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSError *error) {
         [self.commentTableView.mj_header endRefreshing];
    }];
}

- (void)refreshFooter{

    self.page ++;
    BS_Comment *comment = [self.lastestComments lastObject];
    [BS_HttpTools topicCommentDataId:_topic.topicId page:_page lastcid:comment.commentId success:^(id responseObject) {
       
        NSArray *lasts = [BS_Comment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.lastestComments addObjectsFromArray:lasts];
        
        //刷新数据
        [self.commentTableView reloadData];
        
        //判断数组中的数是否大于总数
        if (self.lastestComments.count >= self.totalCount) {
            self.commentTableView.mj_footer.hidden = YES;
        }else{
            [self.commentTableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSError *error) {
        [self.commentTableView.mj_footer endRefreshing];
    }];
}

#pragma mark 添加cell
- (UIView *)addTheTopicCell{

    UIView *headerView = [[UIView alloc]init];
    
    if (self.topic.top_cmt > 0) {
        self.save_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    //初始化cell
    BS_TopicCell *cell = [BS_TopicCell viewFromXib];
    cell.topic = self.topic;
    
    cell.size = CGSizeMake(SCREEN_WIDTH, self.topic.cellHeight);
    [headerView addSubview:cell];
    headerView.height = self.topic.cellHeight + CellMargin;
    headerView.width = SCREEN_WIDTH;
    
    if (_topic.type == BSTopicStateTypeVedio) {
        cell.delegate = self;
    }
    
    return headerView;
}

- (void)topicCellWithCell:(BS_TopicCell *)cell button:(UIButton *)button{
    
    button.hidden = YES;
    self.stopButton = button;
    
    NSString *urlStr = nil;
    NSInteger imageViewtag = 0;
    if (self.topic.type == BSTopicStateTypeSound) {
        urlStr = _topic.voiceuri;
        imageViewtag = 102;
    }else{
        urlStr = _topic.videouri;
        imageViewtag = 101;
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    // 设置player相关参数(需要设置imageView的tag值)
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.playerView setVideoURL:url withTableView:self.commentTableView AtIndexPath:indexPath withImageViewTag:imageViewtag];
    //（可选设置）可以设置视频的填充模式，默认为（等比例填充，直到一个维度到达区域边界）
    self.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:NO];
    [_menu setMenuVisible:NO animated:YES];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger hotCount = self.hotComments.count;
    NSInteger lastestCount = self.lastestComments.count;
    
    if (hotCount > 0) return 3;//最热评论 + 最新评论
    if (lastestCount > 0) return 2;//最新评论
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger hotCount = self.hotComments.count;
    NSInteger lastestCount = self.lastestComments.count;
    
    //是否隐藏尾部
    tableView.mj_footer.hidden = (lastestCount == 0);
    
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return hotCount > 0 ? hotCount : lastestCount;
    }
    return lastestCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.section == 0) {
        return self.topic.cellHeight + CellMargin;
    }else{
        BS_Comment * comment = [self commentInIndexPath:indexPath];
        return comment.cellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 20;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topicCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:[self addTheTopicCell]];
        return cell;
    }else{
        BS_CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCell];
        cell.comment = [self commentInIndexPath:indexPath];
         return cell;
    }

}

- (NSArray *)commentInSection:(NSInteger)section{
    
    if (section == 1) {
        return self.hotComments.count > 0 ? self.hotComments : self.lastestComments;
    }else if (section == 2){
        return self.lastestComments;
    }
    return 0;
}

- (BS_Comment *)commentInIndexPath:(NSIndexPath *)indexPath{
    return [self commentInSection:indexPath.section][indexPath.row];
}

#pragma mark 改变输入框位置
- (void)changeTextFieldLocation{
    self.title = @"评论";
    
    [BSNotfCenter addObserver:self selector:@selector(keyboardWillChangeWithFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark 执行通知
- (void)keyboardWillChangeWithFrame:(NSNotification *)notf{
    
    CGRect rect = [notf.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //底部约束
    self.bottomSapce.constant = SCREEN_HEIGHT - rect.origin.y;
    
    //动画持续时间
    CGFloat duration = [notf.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.save_top_cmt > 0) {
        self.topic.top_cmt = self.save_top_cmt;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
}

#pragma mark UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BS_CommentHeaderView *headerView = [BS_CommentHeaderView commentHeaderViewWithTableView:tableView];
    NSInteger hotCount = self.hotComments.count;
    if (section == 1) {
        headerView.title =  hotCount > 0 ? @"最热评论" : @"最新评论";
    }else if (section == 2){
        headerView.title = @"最新评论";
    }
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if (self.menu.isMenuVisible) {
        [_menu setMenuVisible:NO animated:YES];
    }else if (indexPath.section == 1 || indexPath.section == 2){
      
        BS_CommentCell *cell = (BS_CommentCell *)[tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        
        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"转发" action:@selector(report:)];
        _menu.menuItems = @[ding,replay,report];
        CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
        [_menu setTargetRect:rect inView:cell];
        [_menu setMenuVisible:YES animated:YES];
    }
}

- (void)ding:(UIMenuController *)menu{

    NSIndexPath *indepath = [self.commentTableView indexPathForSelectedRow];
    NSLog(@"%s %@",__func__,[self commentInIndexPath:indepath].content);
}

- (void)replay:(UIMenuController *)menu{
    NSIndexPath *indepath = [self.commentTableView indexPathForSelectedRow];
    NSLog(@"%s %@",__func__,[self commentInIndexPath:indepath].content);
}

- (void)report:(UIMenuController *)menu{
    NSIndexPath *indepath = [self.commentTableView indexPathForSelectedRow];
    NSLog(@"%s %@",__func__,[self commentInIndexPath:indepath].content);
}

@end
