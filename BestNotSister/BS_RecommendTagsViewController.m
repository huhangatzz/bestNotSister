//
//  BS_RecommendTagsViewController.m
//  BestNotSister
//
//  Created by huhang on 16/3/21.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_RecommendTagsViewController.h"
#import "BS_RecommendTagsModel.h"
#import "BS_RecommendTagsCell.h"

@interface BS_RecommendTagsViewController ()<UITableViewDataSource,UITableViewDelegate>

//表格视图
@property (nonatomic,strong)UITableView *tagsTableView;
//数据数组
@property (nonatomic,strong)NSMutableArray *tags;

@end

@implementation BS_RecommendTagsViewController

static NSString * const tagsId = @"tagsid";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建表格
    [self setupTableView];
    
    //加载数据
    [self loadNewData];
}

- (void)loadNewData{

    NSDictionary *params = @{@"a":@"tag_recommend",
                             @"action":@"sub",
                             @"c":@"topic"}.mutableCopy;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            self.tags = [BS_RecommendTagsModel mj_objectArrayWithKeyValuesArray:responseObject];
        }
        [self.tagsTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)setupTableView{

    UITableView *tagTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tagTableView.delegate = self;
    tagTableView.dataSource = self;
    tagTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tagTableView.backgroundColor = [UIColor clearColor];
    tagTableView.allowsSelection = NO;
    [self.view addSubview:tagTableView];
    self.tagsTableView = tagTableView;
    self.tagsTableView.rowHeight = 70;
    
    [self.tagsTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BS_RecommendTagsCell class]) bundle:nil] forCellReuseIdentifier:tagsId];
    
    self.title = @"推荐订阅";
    self.view.backgroundColor = BSTableViewBaceground;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    BS_RecommendTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:tagsId];
    cell.tagsModel = self.tags[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
