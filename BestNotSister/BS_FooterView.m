//
//  BS_PersonFooterView.m
//  BestNotSister
//
//  Created by huhang on 16/5/17.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_FooterView.h"
#import "BS_SquareBtn.h"
#import "BS_Square.h"
#import "BS_PersonWebViewController.h"

/*
 按钮只要没有响应:首先检查视图的高度
*/

@implementation BS_FooterView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
      // [self senderRequestPersonCenterData];
    }
    return self;
}

- (instancetype)initArrs:(NSArray *)lists{
 
    if (self = [super init]) {
        [self setupChildrenView:lists];
    }
    return self;
}

- (void)setupChildrenView:(NSArray *)lists{

    int totals = 4;
    CGFloat width = SCREEN_WIDTH / totals;
    CGFloat height = width;

    for (int i = 0; i < lists.count; i++) {
        
        BS_SquareBtn *button = [BS_SquareBtn buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(VerticalBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        button.square = lists[i];
        [self addSubview:button];
    
        int row = i / totals;
        int col = i % totals;
        
        button.x = col * width;
        button.y = row * height;
        button.width = width;
        button.height = height;
    }
    
    NSInteger rows = (lists.count + totals - 1) / totals;
    
    self.height = rows * height;
}

- (void)VerticalBtnAction:(BS_SquareBtn *)sender{
    
    if ([sender.square.url hasPrefix:@"http://"]) {
        
        BS_PersonWebViewController *webVC = [[BS_PersonWebViewController alloc]init];
        webVC.url = sender.square.url;
        webVC.title = sender.square.name;
        
        // 取出当前的导航控制器
        UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController *nav = (UINavigationController *)tabBarVC.selectedViewController;
        [nav pushViewController:webVC animated:YES];
    }
}


@end
