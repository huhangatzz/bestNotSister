//
//  BS_TagTextField.h
//  BestNotSister
//
//  Created by huhang on 16/5/19.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^deleteBlock)();

@interface BS_TagTextField : UITextField

@property (nonatomic,assign)deleteBlock deleBlock;

@end
