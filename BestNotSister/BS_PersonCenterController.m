//
//  BS_PersonCenterViewController.m
//  BestNotSister
//
//  Created by huhang on 16/3/16.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_PersonCenterController.h"
#import "BS_VerticalBtn.h"
#import "BS_PersonCell.h"
#import "BS_FooterView.h"
#import "BS_Square.h"


static NSString *const MeCell = @"mecell";

@interface BS_PersonCenterController ()

@property (nonatomic,strong)NSArray *titles;

@property (nonatomic,strong)NSMutableArray *squarelists;

@property (nonatomic,strong)BS_FooterView *footerView;

@end

@implementation BS_PersonCenterController

- (NSMutableArray *)squarelists{
    if (!_squarelists) {
        _squarelists = [NSMutableArray array];
    }
    return _squarelists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //调整导航按钮
    [self adjustBarButton];
    
    [self setupTableView];
    
    self.titles = @[@"我的身份",@"本地视频"];
}

- (void)setupTableView{

    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(CellMargin, 0, 0, 0);
    
    [self.tableView registerClass:[BS_PersonCell class] forCellReuseIdentifier:MeCell];
    
    [self senderRequestPersonCenterData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CellMargin;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    BS_PersonCell *cell = [tableView dequeueReusableCellWithIdentifier:MeCell];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
        cell.textLabel.text = @"登录/注册";
    }else if (indexPath.section == 1){
       cell.textLabel.text = self.titles[indexPath.row];
    }
    return cell;
}

#pragma mark 调整导航栏
- (void)adjustBarButton{

    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] heightImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(buttonAction:)];
    UIBarButtonItem *item2 = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] heightImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(buttonAction:)];
    
    self.navigationItem.rightBarButtonItems = @[item1,item2];
}

- (void)buttonAction:(UIButton *)sender{
    BSLogFunc;
}

- (void)senderRequestPersonCenterData{
    
    [BS_HttpTools personCenterSuccess:^(id responseObject) {
        
        NSArray *lists = [BS_Square mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        self.tableView.tableFooterView = [[BS_FooterView alloc]initArrs:lists];
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
