//
//  BS_TopicView.m
//  BestNotSister
//
//  Created by huhang on 16/5/11.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_EssenceView.h"

@interface BS_EssenceView ()<UIScrollViewDelegate>

//标题数组
@property (nonatomic,strong)NSArray *titles;
//子控制器数组
@property (nonatomic,strong)NSArray *viewcontrols;
//按钮数组
@property (nonatomic,strong)NSMutableArray *buttonArrs;
//选择按钮
@property (nonatomic,strong)UIButton *selectBtn;
//滑动视图
@property (nonatomic,strong)UIScrollView *scrollView;
//指示视图
@property (nonatomic,strong)UIView *indicatorView;

@end

@implementation BS_EssenceView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles viewcontrols:(NSArray *)viewcontrols{
    
    if (self = [super initWithFrame:frame]) {
        
        self.titles = titles;
        self.viewcontrols = viewcontrols;
        [self setupAllTopicView];
    }
    return self;
}

- (void)setupAllTopicView{
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.width, SegmentViewH)];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [self addSubview:titleView];
    
    //底部红色指示条
    UIView *indicatorView = [[UIView alloc]init];
    indicatorView.y = titleView.height - 2;
    indicatorView.height = 2;
    indicatorView.backgroundColor = [UIColor redColor];
    [titleView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    //内部子标签
    CGFloat buttonW = self.width / _titles.count;
    CGFloat buttonH = SegmentViewH;
    CGFloat buttonY = 0;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _titles.count; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * buttonW, buttonY, buttonW, buttonH);
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [button addTarget:self action:@selector(titleTagsAction:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        [array addObject:button];
        
        if (i == 0) {
            button.enabled = NO;
            self.selectBtn = button;
            //调整按钮尺寸
            [button.titleLabel sizeToFit];
            //修改指示条宽度
            indicatorView.width = button.titleLabel.width;
            indicatorView.centerX = button.centerX;
         }
     }
    
    self.buttonArrs = array;
    
    [self setupScrollView];
}

/**
 *创建scrollView
 */
- (void)setupScrollView{
   
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    scrollView.backgroundColor = BSTableViewBaceground;
    scrollView.contentSize = CGSizeMake(_viewcontrols.count * scrollView.width, 0);
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    [self addSubview:scrollView];
    //将滑动视图放入最底部
    [self insertSubview:scrollView atIndex:0];
    self.scrollView = scrollView;
    //把控制器视图给显示上去
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

//设置子控制器的属性
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
 
    //添加控制器
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UIViewController *childVC = self.viewcontrols[index];
    childVC.view.x = scrollView.contentOffset.x;
    
    [scrollView addSubview:childVC.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //滑动时改变标签栏
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleTagsAction:self.buttonArrs[index]];
}

- (void)titleTagsAction:(UIButton *)sender{
    
    self.selectBtn.enabled = YES;
    sender.enabled = NO;
    self.selectBtn = sender;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = sender.titleLabel.width;
        self.indicatorView.centerX = sender.centerX;
    }];
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = sender.tag * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];
    
    NSString *tag = [NSString stringWithFormat:@"%zd",sender.tag];
    [BSNotfCenter postNotificationName:ClosePlayerView object:nil userInfo:@{@"key":tag}];
}

@end
