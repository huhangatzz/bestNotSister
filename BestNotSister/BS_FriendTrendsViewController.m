//
//  BS_FriendTrendsViewController.m
//  BestNotSister
//
//  Created by huhang on 16/3/16.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_FriendTrendsViewController.h"
#import "BS_RecommendViewController.h"
#import "BS_LoginRegisterController.h"

#import "BS_LoginTextField.h"

@interface BS_FriendTrendsViewController ()

@end

@implementation BS_FriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   UIBarButtonItem *item = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] heightImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(buttonAction:)];
   self.navigationItem.leftBarButtonItem = item;
    //设置背景色
   self.view.backgroundColor = BSTableViewBaceground;

}

- (void)buttonAction:(UIButton *)sender{
    
    BS_RecommendViewController *recommendVC = [[BS_RecommendViewController alloc]init];
    [self.navigationController pushViewController:recommendVC animated:YES];
    
}

- (IBAction)loginRegister:(id)sender {
    
    BS_LoginRegisterController *loginRegisterVC = [[BS_LoginRegisterController alloc]init];
    [self presentViewController:loginRegisterVC animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
