//
//  BS_EssenceViewController.m
//  BestNotSister
//
//  Created by huhang on 16/3/16.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_EssenceViewController.h"
#import "BS_RecommendTagsViewController.h"
#import "BS_TopicViewController.h"
#import "BS_EssenceView.h"

@interface BS_EssenceViewController ()<UIScrollViewDelegate>

@end

@implementation BS_EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建导航栏
    [self setupNav];
    
    //创建子控制器
    [self setupChindenControl];
    
    //开始创建标签栏了
    [self setupTitleBar];
    
}

#pragma mark 创建子控制器
- (void)setupChindenControl{

    //全部
    BS_TopicViewController *allMessageVC = [[BS_TopicViewController alloc]init];
    allMessageVC.stateType = BSTopicStateTypeAll;
    [self addChildViewController:allMessageVC];
    
    //视频
    BS_TopicViewController *vedioMessageVC = [[BS_TopicViewController alloc]init];
    vedioMessageVC.stateType = BSTopicStateTypeVedio;
    [self addChildViewController:vedioMessageVC];
    
    //声音
    BS_TopicViewController *soundMessageVC = [[BS_TopicViewController alloc]init];
    soundMessageVC.stateType = BSTopicStateTypeSound;
    [self addChildViewController:soundMessageVC];
    
    //图片
    BS_TopicViewController *pictureMessageVC = [[BS_TopicViewController alloc]init];
    pictureMessageVC.stateType = BSTopicStateTypePicture;
    [self addChildViewController:pictureMessageVC];
    
    //段子
    BS_TopicViewController *wordMessageVC = [[BS_TopicViewController alloc]init];
    wordMessageVC.stateType = BSTopicStateTypeWord;
    [self addChildViewController:wordMessageVC];
}

#pragma mark 创建标签栏
- (void)setupTitleBar{

    //有scrollview时需加上
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    BS_EssenceView *essenceView = [[BS_EssenceView alloc]initWithFrame:self.view.bounds titles:titles viewcontrols:self.childViewControllers];
    [self.view addSubview:essenceView];
}

#pragma mark 创建导航栏
- (void)setupNav{
    
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    UIBarButtonItem *item = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] heightImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(buttonAction:)];
    self.navigationItem.leftBarButtonItem = item;
}

#pragma mark 点击导航栏左按钮
- (void)buttonAction:(UIButton *)sender{
    BS_RecommendTagsViewController *recommendTagsVC = [[BS_RecommendTagsViewController alloc]init];
    [self.navigationController pushViewController:recommendTagsVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
