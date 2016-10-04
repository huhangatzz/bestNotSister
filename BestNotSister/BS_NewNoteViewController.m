//
//  BS_NewNoteViewController.m
//  BestNotSister
//
//  Created by huhang on 16/3/16.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_NewNoteViewController.h"

@interface BS_NewNoteViewController ()

@end

@implementation BS_NewNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
   UIBarButtonItem *item = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] heightImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(buttonAction:)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)buttonAction:(UIButton *)sender{
    
    BSLogFunc;
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
