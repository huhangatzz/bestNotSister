//
//  BS_AddTagViewController.h
//  BestNotSister
//
//  Created by huhang on 16/5/19.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BS_AddTagViewController : UIViewController

/** 获取tags的block */
@property (nonatomic, copy) void (^tagsBlock)(NSArray *tags);

/** 所有的标签 */
@property (nonatomic, strong) NSArray *tags;

@end
