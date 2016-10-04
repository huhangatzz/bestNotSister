//
//  BS_VodiceView.h
//  BestNotSister
//
//  Created by huhang on 16/3/31.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BS_Topic;

typedef void (^PlayVodiceBlock)(UIButton *);

@interface BS_VodiceView : UIView

@property (nonatomic,strong)BS_Topic *vodiceModel;

@property (nonatomic,copy)PlayVodiceBlock playBlock;

@property (weak, nonatomic) IBOutlet UIButton *playVoiceBtn;

@end
