//
//  BS_HttpTools.h
//  BestNotSister
//
//  Created by huhang on 16/3/21.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^SuccessBlock)(id responseObject);
typedef void(^FailureBlock)(NSError *error);

typedef NS_ENUM(NSInteger, RequestCachePolicy)
{
    RequestCachePolicyCacheDefault = NSURLRequestUseProtocolCachePolicy,
    RequestCachePolicyIgnoringCacheData = NSURLRequestReloadIgnoringCacheData,
    RequestCachePolicyReturnCacheDataElseLoad = NSURLRequestReturnCacheDataElseLoad,
    RequestCachePolicyReturnCacheDataDontLoad = NSURLRequestReturnCacheDataDontLoad,
};

@interface BS_HttpTools : NSObject

//get请求
+ (NSURLSessionTask *)get:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure cachePolicy:(RequestCachePolicy)cachePolicy;
//post请求
+ (NSURLSessionTask *)post:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure cachePolicy:(RequestCachePolicy)cachePolicy;

/*
 *
 *  关注中推荐关注左侧列表数据
 *
 *  @param success 返回成功后的数据
 *  @param failure 返回失败后的数据
 *
 *  @return 返回数据
 */
+ (NSURLSessionTask *)recommendCategorySuccess:(SuccessBlock)success failure:(FailureBlock)failure;

/*
 *  帖子
 *
 *  @param type       类型
 *  @param page       页数
 *  @param isShowTime 是否展示maxtime
 *  @param maxtime    最大时间
 *  @param success    同上
 *  @param failure    同上
 *
 *  @return 同上
 */
+ (NSURLSessionTask *)topicDataOftype:(NSInteger)type page:(NSInteger)page isShowTime:(BOOL)isShowTime maxtime:(NSString *)maxtime success:(SuccessBlock)success failure:(FailureBlock)failure;

/*
 *  最热评论
 *
 *  @param Id      id
 *  @param success 同上
 *  @param failure 同上
 *
 *  @return 同上
 */
+ (NSURLSessionTask *)topicCommentId:(NSString *)Id success:(SuccessBlock)success failure:(FailureBlock)failure;

/*
 *
 *  最热评论加载更多数据
 *
 *  @param dataId  id
 *  @param page    页数
 *  @param lastcid 最新加载id
 *  @param success 同上
 *  @param failure 同上
 *
 *  @return 同上
 */
+ (NSURLSessionTask *)topicCommentDataId:(NSString *)dataId page:(NSInteger)page lastcid:(NSString *)lastcid success:(SuccessBlock)success failure:(FailureBlock)failure;

/*
 *
 *  个人中心
 *
 *  @param success 同上
 *  @param failure 同上
 *
 *  @return 同上
 */
+ (NSURLSessionTask *)personCenterSuccess:(SuccessBlock)success failure:(FailureBlock)failure;

@end
