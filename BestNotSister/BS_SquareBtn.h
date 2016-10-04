//
//  BS_SquareBtn.h
//  BestNotSister
//
//  Created by huhang on 16/5/18.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BS_Square;
@interface BS_SquareBtn : UIButton

/** 设置文字间距 */
@property (nonatomic,assign)NSInteger textMargin;

@property (nonatomic,strong)BS_Square *square;

@end