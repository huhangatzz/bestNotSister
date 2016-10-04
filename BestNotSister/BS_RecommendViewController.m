//
//  BS_RecommendViewController.m
//  BestNotSister
//
//  Created by huhang on 16/3/19.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_RecommendViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "BS_RecommendModel.h"
#import "BS_UserCategoryModel.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "BS_RecommendCell.h"
#import "BS_UserCategoryCell.h"
#import "BS_HttpTools.h"

#define BSSelectedCategory self.categorys[self.leftTableView.indexPathForSelectedRow.row]

@interface BS_RecommendViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 左边数组 */
@property (nonatomic,strong)NSMutableArray *categorys;

/** 左表格 */
@property (nonatomic,strong)UITableView *leftTableView;
/** 右表格 */
@property (nonatomic,strong)UITableView *rightTableView;

/** 请求管理者 */
@property (nonatomic,strong)AFHTTPSessionManager *manager;

/** 左边数组 */
@property (nonatomic,strong)NSMutableArray *params;

@end

@implementation BS_RecommendViewController

static NSString * const leftCategoryId = @"leftCategoryid";
static NSString * const rightCategoryId = @"rgihtCategoryid";

- (AFHTTPSessionManager *)manager{

    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建视图
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
    
    //加载左侧类别数据
    [self loadCategorys];
}

- (void)loadCategorys{

    //添加小菊花
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    
    NSDictionary *pargams = @{@"a":@"category",
                              @"c":@"subscribe"};
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:pargams success:^(NSURLSessionDataTask *task, id responseObject) {
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            self.categorys = [BS_RecommendModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        }
        
        //刷新数据
        [self.leftTableView reloadData];
        
        //默认选中首行
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        //自动刷新右边数据
        [self.rightTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络有误"];
    }];
}

#pragma mark 创建视图
- (void)setupTableView{

    //左表格
    UITableView *leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 70, SCREEN_HEIGHT) style:UITableViewStylePlain];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.rowHeight = 44;
    leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    leftTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:leftTableView];
    self.leftTableView = leftTableView;
    
    //右表格
    UITableView *rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(70, 0, SCREEN_WIDTH - 70, SCREEN_HEIGHT) style:UITableViewStylePlain];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rightTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:rightTableView];
    self.rightTableView = rightTableView;
  
    //取消自动调整
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.leftTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.rightTableView.contentInset = self.leftTableView.contentInset;
    self.rightTableView.rowHeight = 70;
    
    //注册
    [self.leftTableView registerNib:[UINib nibWithNibName:@"BS_RecommendCell" bundle:nil] forCellReuseIdentifier:leftCategoryId];
    [self.rightTableView registerNib:[UINib nibWithNibName:@"BS_UserCategoryCell" bundle:nil] forCellReuseIdentifier:rightCategoryId];
    
    //设置背景色
    self.view.backgroundColor = BSTableViewBaceground;
    //设置标题
    self.title = @"推荐关注";
}

- (void)setupRefresh{

    //加载头部
    self.rightTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    //加载尾部
    self.rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];

}

//上拉刷新数据
- (void)loadNewUsers{

    BS_RecommendModel *model = BSSelectedCategory;
    
    //设置当前页码
    model.currentage = 1;

    NSMutableArray *params = @{@"a":@"list",
                              @"c":@"subscribe",
                              @"category_id":@(model.recommendId),
                              @"page":@(model.currentage)}.mutableCopy;
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            //字典数组 -> 模型数组
            NSArray *users = [BS_UserCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            //清楚所以旧数据
            [model.users removeAllObjects];
            //添加到当前对应类别的数组中
            [model.users addObjectsFromArray:users];
            //保存总数
            model.total = [responseObject[@"total"] integerValue];
            //不是最后一次请求(防止快速点击左边每个item)
            if (self.params != params) return;
            //结束刷新
            [self.rightTableView.mj_header endRefreshing];
            //让底部控件结束刷新
            [self checkFooterState];
        }
        //刷新数据
        [self.rightTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return ;
            
        //提醒
        [SVProgressHUD showErrorWithStatus:@"网络有误"];
        
        //结束刷新
        [self.rightTableView.mj_header endRefreshing];
    }];
    
}

//下拉加载新数据
- (void)loadMoreUsers{

    BS_RecommendModel *model = BSSelectedCategory;
    
    NSMutableArray *params = @{@"a":@"list",
                               @"c":@"subscribe",
                               @"category_id":@(model.recommendId),
                               @"page":@(++model.currentage)}.mutableCopy;
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            //字典数组 -> 模型数组
            NSArray *users = [BS_UserCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            //添加到当前对应类别的数组中
            [model.users addObjectsFromArray:users];
            
            //不是最后一次请求
            if (self.params != params) return ;
            
            //刷新数据
            [self.rightTableView reloadData];
            
            //让底部控件结束刷新
            [self checkFooterState];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return ;
        
        //提醒
        [SVProgressHUD showErrorWithStatus:@"网络有误"];
        
        //结束刷新
        [self.rightTableView.mj_footer endRefreshing];
    }];

}

//时刻监测footer的状态
- (void)checkFooterState{

    BS_RecommendModel *model = BSSelectedCategory;
    
    //每次刷新右边数据时,都控制footer的显示或者隐藏
    self.rightTableView.mj_footer.hidden = (model.users.count == 0);
    
    //让底部控件结束刷新
    if (model.users.count == model.total) {
        [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.rightTableView.mj_footer endRefreshing];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return self.categorys.count;
    }else{
        //监测footer状态
        [self checkFooterState];
        return [BSSelectedCategory users].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == self.leftTableView) {
        BS_RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCategoryId];
        cell.recommendModel = self.categorys[indexPath.row];
        return cell;
    }else{
    
        BS_UserCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:rightCategoryId];
        cell.userModel = [BSSelectedCategory users][indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == self.rightTableView) return;
    
    //结束刷新
    [self.rightTableView.mj_header endRefreshing];
    [self.rightTableView.mj_footer endRefreshing];
    
    BS_RecommendModel *model = self.categorys[indexPath.row];
    
    //解决重复请求数据
    if (model.users.count > 0) {
        [self.rightTableView reloadData];
    }else{
        //赶紧刷新表格,目的是:马上显示当前category的数据,不让用户看见上个category的残留数据
        [self.rightTableView reloadData];
        
        //进入下拉刷新状态
        [self.rightTableView.mj_header beginRefreshing];
    }
}

#pragma mark 控制器的销毁
- (void)dealloc{
    //停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
