//
//  BS_PublishViewController.m
//  BestNotSister
//
//  Created by huhang on 16/3/30.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_PublishViewController.h"
#import "BS_VerticalBtn.h"
#import "BS_PostwordViewController.h"
#import "BS_NavigationViewController.h"

@interface BS_PublishViewController ()

/** 发布按钮 */
@property(nonatomic,strong)BS_VerticalBtn *publishBtn;

@end

@implementation BS_PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *images = @[@"publish-text",@"publish-video",@"publish-offline",@"publish-review",@"publish-picture",@"publish-audio"];
    NSArray *titles = @[@"发段子",@"发视频",@"发离线",@"审贴",@"发图片",@"发声音"];
    
    NSInteger count = 3;
    CGFloat publishW = 72;
    CGFloat publishH = 100;
    CGFloat margin = (SCREEN_WIDTH - count * publishW)/ (count + 1);
    
    for (int i = 0; i < titles.count; i ++) {
        
        NSInteger row = i / count;
        NSInteger cal = i % count;
        CGFloat publishX = margin + cal * (margin + publishW);
        CGFloat publishY = 100 + margin + row * (margin + publishH);
        
        BS_VerticalBtn *publishBtn = [BS_VerticalBtn buttonWithType:UIButtonTypeCustom];
        publishBtn.textMargin = 15;//文字间距
        publishBtn.frame = CGRectMake(publishX, publishY, publishW, publishH);
        [publishBtn setTitle:titles[i] forState:UIControlStateNormal];
        [publishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [publishBtn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [publishBtn addTarget:self action:@selector(publishBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:publishBtn];
    }
    
}

- (void)publishBtnAction{

    
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
