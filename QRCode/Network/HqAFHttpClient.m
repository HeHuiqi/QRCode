//
//  HQAFHttpClient.m
//  NetworkTest
//
//  Created by macpro on 16/3/18.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import "HqAFHttpClient.h"

@implementation HqAFHttpClient

+(AFHTTPSessionManager *)shareOperationManager
{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
    });
    return manager;
}


+ (AFHTTPSessionManager *)initMangerWithHeaders:(NSDictionary *)headers
                                       requestIsNeedJson:(BOOL)reqIsNeed
                                      responseIsNeedJson:(BOOL)respIsNeed
{
    AFHTTPSessionManager *manager = [self shareOperationManager];
    if (reqIsNeed)
    {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    else
    {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    
    
    if (respIsNeed)
    {
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    else
    {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    if (headers)
    {
        [headers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    NSString *token = GetUserDefault(kToken);
    NSLog(@"token==%@",token);
    if (token.length > 0) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"x-access-token"];
    }
//        NSLog(@"responseSerializer =%@",manager.requestSerializer.class);

//    NSLog(@"header =%@",manager.requestSerializer.HTTPRequestHeaders);
    return manager;
}
+ (void)cancelRequest
{
    [[self shareOperationManager].operationQueue cancelAllOperations];
}

+ (void)tokenInvalid{
    
   
  // 登录失效 断开连接
    SetUserDefault(@"", kToken);
    SetUserDefault(@"", kUserBankCardNumber);
//    [AppDelegate setRootVCIsLogin:NO];
    
}


+ (void)starRequestWithHeaders:(NSDictionary *)headers
                 withURLString:(NSString *)urlString
                     withParam:(NSDictionary *)param
             requestIsNeedJson:(BOOL)reqIsNeed
            responseIsNeedJson:(BOOL)respIsNeed
                        requestMethod:(RequestMethod)method
            requestCompleBlock:(HqHttpRequestResultBlock)block
{
    
    NSLog(@"paramJson==%@",param.mj_JSONString);
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status<=0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [Dialog simpleToast:@"网络未连接"];
                [SVProgressHUD dismiss];
            });
        }
    }];
    //    NSLog(@"nertwork==%d",[AFNetworkReachabilityManager sharedManager].reachable)
    if (![AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
        return;
    }
    AFHTTPSessionManager  *manager = [self initMangerWithHeaders:headers requestIsNeedJson:reqIsNeed responseIsNeedJson:respIsNeed];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",SERVSER_URL,urlString];
    
    if ([urlString hasPrefix:@"http"]) {
        url = urlString;
    }
    
    switch (method) {
        case Get:
        {
            [manager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
             
                
                [self requestSueccesResult:response responseObject:responseObject resultBlock:block];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                [self requestFailResult:response resultBlock:block error:error];
                
            }];
        }
            break;
            
        case Post:
        {
            [manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
               [self requestSueccesResult:response responseObject:responseObject resultBlock:block];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                [self requestFailResult:response resultBlock:block error:error];
            }];
        }
            break;
        case Put:
        {
            [manager PUT:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
               [self requestSueccesResult:response responseObject:responseObject resultBlock:block];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                [self requestFailResult:response resultBlock:block error:error];
            }];
        }
            break;
            
        case Delete:
        {
            [manager DELETE:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
               [self requestSueccesResult:response responseObject:responseObject resultBlock:block];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                [self requestFailResult:response resultBlock:block error:error];
                
            }];
        }
            break;
            
            
        default:
            break;
    }
    NSLog(@"url==%@",url);
    
}
+ (void)requestSueccesResult:(NSHTTPURLResponse *)response
         responseObject:(id)responseObject
             resultBlock:(HqHttpRequestResultBlock)block
{
    NSLog(@"http-statusCode == %d",(int)response.statusCode);
    if ([responseObject isKindOfClass:[NSDictionary class]])
    {
        int status = [[responseObject hq_objectForKey:@"status"] intValue];
        if (status >=4001 && status<=4005 && ![response.URL.absoluteString hasSuffix:@"login"] ) {
            [self tokenInvalid];
            block(nil,nil,nil);
        }else{
            block(response,responseObject,nil);
        }
        
        
    }
    else
    {
        //返回的是二进制数据
        if ([response isKindOfClass:[NSData class]])
        {
            id resp = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            block(response,resp,nil);
        }
        else
        {
            block(response,responseObject,nil);
        }
    }
    
}
+ (void)requestFailResult:(NSHTTPURLResponse *)response
              resultBlock:(HqHttpRequestResultBlock)block error:(NSError *)error
{
    NSLog(@"http-statusCode == %d",(int)response.statusCode);
    
    if (![response.URL.absoluteString hasSuffix:@"login"]&&response.statusCode == 401) {
        [self tokenInvalid];
    }else{
        if (response.statusCode >= 500) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [Dialog simpleToast:@"服务开小差"];
            });
            
        }
    }
    block(response,nil,error);
    
}


@end
