//
//  BS_PushGuideView.m
//  BestNotSister
//
//  Created by huhang on 16/3/23.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_PushGuideView.h"

@implementation BS_PushGuideView

+ (void)showPushGuideView{

    NSString *key = @"CFBundleShortVersionString";
    //获取当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //获取沙盒中的版本号
    NSString *saxbookVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];

    if (![currentVersion isEqualToString:saxbookVersion]) {
        BS_PushGuideView *pushGuideView = [BS_PushGuideView viewFromXib];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        pushGuideView.frame = window.bounds;
        [window addSubview:pushGuideView];

        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)back {
    [self removeFromSuperview];
}


@end
