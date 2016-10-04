//
//  BS_TabBarViewController.m
//  BestNotSister
//
//  Created by huhang on 16/3/16.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_TabBarViewController.h"
#import "BS_PublishTabBar.h"
#import "BS_NavigationViewController.h"

#import "BS_EssenceViewController.h"
#import "BS_NewNoteViewController.h"
#import "BS_FriendTrendsViewController.h"
#import "BS_PersonCenterController.h"
@interface BS_TabBarViewController ()

@end

@implementation BS_TabBarViewController

+ (void)initialize{

    NSDictionary *titleAttrs = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor grayColor]};
    NSDictionary *selectTitleAttrs = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    
    //统一设置文字属性
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:titleAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectTitleAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //精华
    [self setupChildController:[[BS_EssenceViewController alloc]init] title:@"精华" imageName:[UIImage imageNamed:@"tabBar_essence_icon"] selectImage:[UIImage imageNamed:@"tabBar_essence_click_icon"]];
    //新帖
    [self setupChildController:[[BS_NewNoteViewController alloc]init] title:@"新帖" imageName:[UIImage imageNamed:@"tabBar_new_icon"] selectImage:[UIImage imageNamed:@"tabBar_new_click_icon"]];
    //关注
    [self setupChildController:[[BS_FriendTrendsViewController alloc]init] title:@"关注" imageName:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selectImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"]];
    //我的
    [self setupChildController:[[BS_PersonCenterController alloc]init] title:@"我的" imageName:[UIImage imageNamed:@"tabBar_me_icon"] selectImage:[UIImage imageNamed:@"tabBar_me_click_icon"]];
    
    [self setValue:[[BS_PublishTabBar alloc]init] forKey:@"tabBar"];
}

- (void)setupChildController:(UIViewController *)vc title:(NSString *)title imageName:(UIImage *)image selectImage:(UIImage *)selectImage{

    vc.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectImage;
    BS_NavigationViewController *nav = [[BS_NavigationViewController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
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
