//
//  BS_CommentHeaderView.h
//  BestNotSister
//
//  Created by huhang on 16/5/13.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BS_CommentHeaderView : UITableViewHeaderFooterView

/** 文字数据 */
@property (nonatomic,copy)NSString *title;

+ (instancetype)commentHeaderViewWithTableView:(UITableView *)tableView;

@end
