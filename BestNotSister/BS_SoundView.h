//
//  BS_SoundViewCell.h
//  BestNotSister
//
//  Created by huhang on 16/3/31.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BS_Topic;

typedef void (^PlaySoundBlock)(UIButton *);

@interface BS_SoundView : UIView

@property (nonatomic,strong)BS_Topic *soundModel;

@property (nonatomic,copy)PlaySoundBlock playBlock;

@end
