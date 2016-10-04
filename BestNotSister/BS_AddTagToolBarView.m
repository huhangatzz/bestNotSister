//
//  BS_AddTagToolBar.m
//  BestNotSister
//
//  Created by huhang on 16/5/19.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_AddTagToolBarView.h"
#import "BS_AddTagViewController.h"
#import "BS_NavigationViewController.h"

@interface BS_AddTagToolBarView ()

@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation BS_AddTagToolBarView

- (void)awakeFromNib{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [button sizeToFit];
    button.x = CellMargin;
    [self.topView addSubview:button];
}

- (void)buttonAction:(UIButton *)sender{

    BS_AddTagViewController *tagVC = [[BS_AddTagViewController alloc]init];
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)rootVC.presentedViewController;
    [nav pushViewController:tagVC animated:YES];
}

@end
