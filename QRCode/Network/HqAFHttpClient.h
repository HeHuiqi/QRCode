//
//  HQAFHttpClient.h
//  NetworkTest
//
//  Created by macpro on 16/3/18.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <AFNetworking.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(int,RequestMethod){
    Get =1,
    Post,
    Put,
    Delete
};
typedef void (^HqHttpRequestCompleteBlock) (NSHTTPURLResponse *response, id responseObject);

typedef void (^HqHttpRequestResultBlock) (NSHTTPURLResponse *response, id responseObject,NSError *error);

@interface HqAFHttpClient : NSObject

+(AFHTTPSessionManager *)shareOperationManager;

/**
 发起一个请求
 
 @param headers 头信息
 @param urlString api地址
 @param param 请求参数
 @param reqIsNeed 请求参数是否为json格式
 @param respIsNeed 返回参数是否为json格式
 @param method 请求方式
 @param block 请求结果Block 带有error信息
 */
+ (void)starRequestWithHeaders:(NSDictionary *)headers
                 withURLString:(NSString *)urlString
                     withParam:(NSDictionary *)param
             requestIsNeedJson:(BOOL)reqIsNeed
            responseIsNeedJson:(BOOL)respIsNeed
                 requestMethod:(RequestMethod)method
            requestCompleBlock:(HqHttpRequestResultBlock)block;

/**
 取消一个请求
 */
+ (void)cancelRequest;
//登录异常
+ (void)tokenInvalid;
@end
