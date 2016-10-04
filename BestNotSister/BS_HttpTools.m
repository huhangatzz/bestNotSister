//
//  BS_HttpTools.m
//  BestNotSister
//
//  Created by huhang on 16/3/21.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "BS_HttpTools.h"

@implementation BS_HttpTools
//get方法
+ (NSURLSessionTask *)get:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure cachePolicy:(RequestCachePolicy)cachePolicy{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.cachePolicy = (NSURLRequestCachePolicy) cachePolicy;
    //请求多长时间
    manager.requestSerializer.timeoutInterval = 15;
   // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/javascript", nil];
    
    NSURLSessionTask *session = [manager GET:urlStr parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    return session;
}

//POST方法
+ (NSURLSessionTask *)post:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure cachePolicy:(RequestCachePolicy)cachePolicy{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.cachePolicy = (NSURLRequestCachePolicy)cachePolicy;
    //请求多长时间
    manager.requestSerializer.timeoutInterval = 15;
   manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/javascript", nil];
    
    NSURLSessionTask *session = [manager POST:urlStr parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    
    return session;
}

+ (NSURLSessionTask *)recommendCategorySuccess:(SuccessBlock)success failure:(FailureBlock)failure{

    NSDictionary *pargams = @{@"a":@"category",
                              @"c":@"subscribe"};
   return [self get:LEFTRECOMMENDURL parameters:pargams success:success failure:failure cachePolicy:RequestCachePolicyCacheDefault];
}

+ (NSURLSessionTask *)topicDataOftype:(NSInteger)type page:(NSInteger)page isShowTime:(BOOL)isShowTime maxtime:(NSString *)maxtime success:(SuccessBlock)success failure:(FailureBlock)failure{

    NSMutableDictionary *params = @{@"a":@"list",
                             @"c":@"data",
                             @"type":@(type),
                             @"page":@(page)}.mutableCopy;
    if (isShowTime) {
        [params setValue:maxtime forKey:@"maxtime"];
    }
    
    return [self get:EssenceTopicUrl parameters:params success:success failure:failure cachePolicy:RequestCachePolicyCacheDefault];
}

+ (NSURLSessionTask *)topicCommentId:(NSString *)Id success:(SuccessBlock)success failure:(FailureBlock)failure{

    NSDictionary *params = @{@"a":@"dataList",
                             @"c":@"comment",
                             @"data_id":Id,
                             @"hot":@"1"};
    return [self get:EssenceCommentUrl parameters:params success:success failure:failure cachePolicy:RequestCachePolicyCacheDefault];
}

+ (NSURLSessionTask *)topicCommentDataId:(NSString *)dataId page:(NSInteger)page lastcid:(NSString *)lastcid success:(SuccessBlock)success failure:(FailureBlock)failure{
    
    NSString *pageStr = [NSString stringWithFormat:@"%zd",page];
    NSDictionary *params = @{@"a":@"dataList",
                             @"c":@"comment",
                             @"data_id":[dataId description],
                             @"page":[pageStr description],
                             @"lastcid":[lastcid description]};
    
    return [self get:EssenceCommentUrl parameters:params success:success failure:failure cachePolicy:RequestCachePolicyCacheDefault];
}

+ (NSURLSessionTask *)personCenterSuccess:(SuccessBlock)success failure:(FailureBlock)failure{

    NSDictionary *params = @{@"a":@"square",
                             @"c":@"topic"};
    return [self get:PersonCenterUrl parameters:params success:success failure:failure cachePolicy:RequestCachePolicyCacheDefault];
}

@end
