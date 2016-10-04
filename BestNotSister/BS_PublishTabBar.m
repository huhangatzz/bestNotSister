//
//  BS_PublishTabBar.m
//  BestNotSister
//
//  Created by huhang on 16/3/16.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_PublishTabBar.h"
#import "BS_PublishViewController.h"


#import "BS_NavigationViewController.h"
#import "BS_PostwordViewController.h"

@implementation BS_PublishTabBar

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        //创建button
        UIButton *publisthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [publisthBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publisthBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publisthBtn addTarget:self action:@selector(publishAction) forControlEvents:UIControlEventTouchUpInside];
        [publisthBtn sizeToFit];
        [self addSubview:publisthBtn];
        self.publishBtn = publisthBtn;
    }
    return self;
}

- (void)publishAction{

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[BS_PublishViewController alloc]init] animated:NO completion:nil];
    
//    BS_PostwordViewController *postwordVC = [[BS_PostwordViewController alloc]init];
//    BS_NavigationViewController *rootNC = [[BS_NavigationViewController alloc]initWithRootViewController:postwordVC];
//    
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:rootNC animated:YES completion:nil];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //判断按钮是否被监听
    static BOOL addObserve = NO;
    
    CGFloat width = self.width;
    CGFloat height = self.height;

    // 设置其他UITabBarButton的frame
    CGFloat subBtnX = 0;
    CGFloat subBtnY = 0;
    CGFloat subBtnW = width / 5;
    CGFloat subBtnH = height;
    NSInteger index = 0;
    
    for (UIButton *tabBtn in self.subviews) {
        
        if (![tabBtn isKindOfClass:[UIControl class]] || self.publishBtn == tabBtn) continue;
        
        if (index == 2){index = 3;}
         // 计算按钮的x值
        subBtnX = subBtnW * index;
        tabBtn.frame = CGRectMake(subBtnX, subBtnY, subBtnW,subBtnH);
          // 增加索引
        index ++ ;
        
        if (addObserve == NO) {
            // 监听按钮点击
            [tabBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    //设置button的frame
    self.publishBtn.center = CGPointMake(width * 0.5, height * 0.5);
    
    addObserve = YES;
}

- (void)buttonAction{
  // 发出一个通知
  [[NSNotificationCenter defaultCenter] postNotificationName:TabBarDidSelectNotification object:nil];
    
}

@end
