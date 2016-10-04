//
//  BS_TopicViewController.m
//  BestNotSister
//
//  Created by huhang on 16/3/28.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_TopicViewController.h"
#import "BS_TopicCell.h"
#import "BS_Topic.h"
#import "UIImageView+WebCache.h"
#import "BS_CommentViewController.h"
#import "ZFPlayer.h"

@interface BS_TopicViewController ()<UITableViewDelegate,UITableViewDataSource,TopicCellDelegate>

/** 帖子数据 */
@property (nonatomic,strong)UITableView *topicTableView;

/** 帖子数据 */
@property (nonatomic,strong)NSMutableArray *dataSources;

/** 页数 */
@property (nonatomic,assign)NSInteger pageIndex;

/** 加载下一页需要传入这个参数 */
@property (nonatomic,copy)NSString *maxtime;

/** 参数 */
@property (nonatomic,strong)NSDictionary *params;

/** 上一次选中的索引 */
@property (nonatomic,assign)NSInteger lastSelectIndex;

/** 视频播放视图 */
@property (nonatomic,strong)ZFPlayerView *playerView;

/** 目前状态 */
@property (nonatomic,copy)NSString *currentTag;

/** 展示播放状态数据 */
@property (nonatomic,strong)NSMutableArray *showplayData;

@property (nonatomic,strong)NSIndexPath *indexPath;

@end

@implementation BS_TopicViewController

static NSString * const wordMessageCellId = @"wordMessageId";

/**
 *懒加载
 */
- (NSMutableArray *)dataSources{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

- (NSMutableArray *)showplayData{
    if (!_showplayData) {
        _showplayData = [NSMutableArray array];
    }
    return _showplayData;
}

//- (ZFPlayerView *)playerView{
// 
//    if (!_playerView) {
//        _playerView = [ZFPlayerView sharedPlayerView];
//    }
//    return _playerView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentTag = 0;
    
    //创建tableView
    [self setupTableView];
    
    //下拉刷新
    [self setupRefresh];
    
    //监听点击tabbar通知
    [BSNotfCenter addObserver:self selector:@selector(selectTabBar) name:TabBarDidSelectNotification object:nil];
    [BSNotfCenter addObserver:self selector:@selector(closePlayerView:) name:ClosePlayerView object:nil];
    //显示暂停按钮
    [BSNotfCenter addObserver:self selector:@selector(showStopButton) name:@"backButtonAction" object:nil];
}

- (void)dealloc{
    [BSNotfCenter removeObserver:self];
}

#pragma mark 点击两次tabBar时
- (void)selectTabBar{

    // 如果是连续选中2次, 直接刷新
    if (self.lastSelectIndex == self.tabBarController.selectedIndex && self.view.isShowOnKeyWindow) {
        [self.topicTableView.mj_header beginRefreshing];
    }
    
    // 记录这一次选中的索引
    self.lastSelectIndex = self.tabBarController.selectedIndex;
}

#pragma mark 解决小播放器不消失的问题
- (void)closePlayerView:(NSNotification *)notf{
    
    NSString *tag = notf.userInfo[@"key"];
    if (![tag isEqualToString:self.currentTag]) {
        [self .playerView backButtonAction];
        self.currentTag = tag;
    }
}

#pragma mark 显示暂停按钮
- (void)showStopButton{
    BS_Topic *showTopic = [[BS_Topic alloc]init];
    showTopic.isShowStopBtn = NO;
    [self.showplayData replaceObjectAtIndex:_indexPath.row withObject:showTopic];
    [self.topicTableView reloadData];
}

- (void)setupTableView{

    UITableView *topicTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    topicTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    topicTableView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    topicTableView.delegate = self;
    topicTableView.dataSource = self;
    
    topicTableView.delaysContentTouches = NO;
    
    //设置内边距
    topicTableView.contentInset = UIEdgeInsetsMake(64 + SegmentViewH, 0, 49 + 10, 0);
    topicTableView.scrollIndicatorInsets = topicTableView.contentInset;
    [self.view addSubview:topicTableView];
    self.topicTableView = topicTableView;
    
     self.automaticallyAdjustsScrollViewInsets = NO;
    //注册
    [self.topicTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BS_TopicCell class]) bundle:nil] forCellReuseIdentifier:wordMessageCellId];
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    return YES;
}

- (void)setupRefresh{
    
    //刷新头部
    self.topicTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    //隐藏头部
    self.topicTableView.mj_header.automaticallyChangeAlpha = YES;
    //刷新尾部
    self.topicTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    //自动开始刷新
    [self.topicTableView.mj_header beginRefreshing];
}

#pragma mark 刷新头部
- (void)headerRefresh{
    
    self.pageIndex = 0;
    [BS_HttpTools topicDataOftype:_stateType page:_pageIndex isShowTime:NO maxtime:@"" success:^(id responseObject) {
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 数组 -> 模型
        self.dataSources = [BS_Topic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.showplayData removeAllObjects];
        for (int i = 0; i < self.dataSources.count; i ++) {
            BS_Topic *topic = [[BS_Topic alloc]init];
            topic.isShowStopBtn = NO;
            [self.showplayData addObject:topic];
        }
        
        [self.topicTableView reloadData];
        
        //结束刷新
        [self.topicTableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        //结束刷新
        [self.topicTableView.mj_header endRefreshing];
    }];
}

#pragma mark 刷新尾部
- (void)footerRefresh{
    
    self.pageIndex++;
    [BS_HttpTools topicDataOftype:_stateType page:_pageIndex isShowTime:YES maxtime:_maxtime success:^(id responseObject) {
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 数组 -> 模型
        NSArray *array = [BS_Topic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.dataSources addObjectsFromArray:array];
        
        for (int i = 0; i < array.count; i ++) {
            BS_Topic *topic = [[BS_Topic alloc]init];
            topic.isShowStopBtn = NO;
            [self.showplayData addObject:topic];
        }
        
        [self.topicTableView reloadData];
        
        //结束刷新
        [self.topicTableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        //结束刷新
        [self.topicTableView.mj_footer endRefreshing];
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BS_Topic *model = self.dataSources[indexPath.row];
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BS_TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:wordMessageCellId];
    
    cell.topic = self.dataSources[indexPath.row];
    
    BS_Topic *top = self.showplayData[indexPath.row];
    cell.showStopBtnSate = top.isShowStopBtn;
    cell.delegate = self;
    
    for (id obj in cell.subviews)
    {
        if ([NSStringFromClass([obj class])isEqualToString:@"UITableViewCellScrollView"])
        {
            UIScrollView *scroll = (UIScrollView *) obj;
            scroll.delaysContentTouches =NO;
            break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"-------------%s",__func__);
}

#pragma mark PlayVodiceDelegate
- (void)topicCellWithCell:(BS_TopicCell *)cell button:(UIButton *)button{

    NSLog(@"%s",__func__);
    
    NSIndexPath *indexPath = [self.topicTableView indexPathForCell:cell];
    self.indexPath = indexPath;
    
    //取出模型
    BS_Topic *topic = self.dataSources[indexPath.row];
    
    //初始化播放器
    self.playerView = [ZFPlayerView sharedPlayerView];
    
    NSString *urlStr = nil;
    NSInteger imageViewtag = 0;
    if (self.stateType == BSTopicStateTypeSound) {
        urlStr = topic.voiceuri;
        imageViewtag = 102;
    }else{
        urlStr = topic.videouri;
        imageViewtag = 101;
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    // 设置player相关参数(需要设置imageView的tag值)
    [self.playerView setVideoURL:url withTableView:self.topicTableView AtIndexPath:indexPath withImageViewTag:imageViewtag];
     //（可选设置）可以设置视频的填充模式，默认为（等比例填充，直到一个维度到达区域边界）
    self.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    
    BS_Topic *showTopic = [[BS_Topic alloc]init];
    showTopic.isShowStopBtn = YES;
    [self.showplayData replaceObjectAtIndex:indexPath.row withObject:showTopic];
    [self.topicTableView reloadData];
}

//点击cell时
- (void)topicCellWithCell:(BS_TopicCell *)cell clickBtn:(UIButton *)clickBtn{
 
    NSIndexPath *indexPath = [self.topicTableView indexPathForCell:cell];
    BS_CommentViewController *commentVC = [[BS_CommentViewController alloc]init];
    commentVC.topic = self.dataSources[indexPath.row];
    [self.navigationController pushViewController:commentVC animated:YES];
}

// 页面消失时候
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.playerView resetPlayer];

}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        self.view.backgroundColor = [UIColor whiteColor];
    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        self.view.backgroundColor = [UIColor blackColor];
    }
}

@end
