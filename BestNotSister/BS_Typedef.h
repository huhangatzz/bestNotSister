//
//  BS_Typedef.h
//  BestNotSister
//
//  Created by huhang on 16/3/28.
//  Copyright © 2016年 huhang. All rights reserved.
//

#ifndef BS_Typedef_h
#define BS_Typedef_h

typedef NS_ENUM (NSInteger,BSTopicStateType){
    
    BSTopicStateTypeAll = 1, //全部
    BSTopicStateTypePicture = 10,//图片
    BSTopicStateTypeWord = 29,  //段子
    BSTopicStateTypeSound = 31, //声音
    BSTopicStateTypeVedio = 41  //视频
};

//精华页顶部分段视图的高度
#define SegmentViewH 40

//cell间距
#define CellMargin 10
#define TagMargin 5

#define SYSTEM_VERSION   [[[UIDevice currentDevice]systemVersion]floatValue]
#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH_SCALE [UIScreen mainScreen].bounds.size.width/320.0
#define SCREEN_HEIGHT_SCALE ([UIScreen mainScreen].bounds.size.height-64)/(568.0-64)

#define kUserDefaults [NSUserDefaults standardUserDefaults]

#define BSNotfCenter  [NSNotificationCenter defaultCenter]

//Toast提示语的配置
#define NET_CONNETCT_WRONG       @"网络异常，请检查网络设置"
#define NO_MORE_DATA             @"没有更多数据了"

//通知
#define TabBarDidSelectNotification @"TabBarDidSelectNotification"
#define ClosePlayerView             @"ClosePlayerView"

// 获取主线程
#define kMainThread (dispatch_get_main_queue())
// 全局线程
#define kGlobalThread dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#define APPDELEGATE MP_AppDelegate *app = (MP_AppDelegate *)([UIApplication sharedApplication].delegate)

#define DF_Color_RGB(a,b,c) [UIColor colorWithRed:a/255.0f green:b/255.0f blue:c/255.0f alpha:1]
#define Color_RGB(a,b,c,d) [UIColor colorWithRed:a/255.0f green:b/255.0f blue:c/255.0f alpha:d]

#define PSIZE 20

/***字体样式，大小，颜色的定义**/

//通用字体 冬青黑体
#define NORMAL_FONT                    @"Heiti SC"
#define NORMAL_FONT_BOLD               @"Heiti SC-Bold"

//本项字体标注颜色
//常规字体 黑色
#define NORMAL_BLACK_COLOR              @"#000000"
//按钮的白色标题颜色
#define TITLE_COLOR_BUTTON              @"#ffffff"
//按钮蓝色标题颜色
#define TITLE_BLUE_BUTTON               @"#3492E9"
//提示错误颜色
#define NOTE_ERROR_COLOR                @"#FF4BOO"
//总收入
#define TOTAL_INCOME_COLOR              @"#0084FF"
//总收入
#define TOTAL_EXPENDITURE_COLOR         @"#4FB237"
//利润
#define PROFITS_COLOR                   @"#F96D17"
//流动资产
#define CURRENT_ASSET_COLOR             @"#62C2FF"
//非流动资产
#define NON_CURRENT_ASSET_COLOR         @"#FAAA16"
//负债
#define LIBILITY_COLOR                  @"#22AAC2F"
//流动负债
#define CURRENT_LIBILITY_COLOR          @"#6ED271"
//非流动负债
#define NON_CURRENT_LIBILITY_COLOR      @"#6DD1A2"
//所有者权益
#define OWNERSHIP_INTEREST_COLOR        @"#ff8067"
//价格 资金
#define PRICE_EXTRUDE_COLOR             @"#FF4C00"
//蓝色按钮
#define BLUE_BTN_COLOR                  @"36B1FF"

//透明度
#define NORMAL_ALPHA_VALUE1             0.87
#define NORMAL_ALPHA_VALUE2             0.78
#define NORMAL_ALPHA_VALUE3             0.54

//字号
//导航标题字号
#define TopBar_Font_Size                18.0
//常规字体字号
#define Normal_Font_Size                16.0
//小字体字号
#define Small_Font_Size1                15.0
#define Small_Font_Size2                13.0

//旧项目的背景颜色
//背景色
#define DEFAULT_BACKGROUND_COLOR       @"#f8f8f8"
//分割线颜色
#define SPLIT_LINE_COLOR               @"#d9d9d9"
//账户页面字体颜色
#define FONT_COLOR_ACCOUNT             @"#333333"
//账户页面标注颜色
#define FONT_COLOR_ACCTOUN_NOTE        @"#999999"
//黑体字体颜色
#define BLACK_COLOR_TEXT               @"#000000"
//标题字体色值
#define Title_Font_Color               @"#666666"
//注释字体色值
#define Note_Font_Color                @"#bebebe"
//默认holder字体色值
#define Placeholeder_Font_color        @"#cdcdcd"
//背景色灰度值
#define Default_Background_Color       @"#f8f8f8"

#endif /* BS_Typedef_h */
