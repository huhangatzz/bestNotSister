//
//  BS_PlaceholderTextView.h
//  BestNotSister
//
//  Created by huhang on 16/5/18.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BS_PlaceholderTextView : UITextView

/** 占位颜色 */
@property (nonatomic,strong)UIColor *placeholderColor;
/** 占位文字 */
@property (nonatomic,copy)NSString *placeholder;

@end
