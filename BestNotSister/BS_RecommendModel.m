//
//  BS_RecommendModel.m
//  BestNotSister
//
//  Created by huhang on 16/3/19.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_RecommendModel.h"

@implementation BS_RecommendModel

+ (NSDictionary *)replacedKeyFromPropertyName{

    return @{@"recommendId" : @"id"};
}


- (NSMutableArray *)users{

    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
