//
//  HqHttpUtil.m
//  QRCode
//
//  Created by macpro on 2018/1/8.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqHttpUtil.h"
#import "HqAFHttpClient.h"
@implementation HqHttpUtil

+ (void)hqGet:(NSDictionary *)param url:(NSString *)url complete:(HqHttpUtilResultBlock)block{
    
    [HqAFHttpClient starRequestWithHeaders:nil withURLString:url withParam:param requestIsNeedJson:YES responseIsNeedJson:YES requestMethod:Post requestCompleBlock:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        block(response,responseObject,error);
    }];
}
+ (void)hqPost:(NSDictionary *)param url:(NSString *)url complete:(HqHttpUtilResultBlock)block{
    
    [HqAFHttpClient starRequestWithHeaders:nil withURLString:url withParam:param requestIsNeedJson:YES responseIsNeedJson:YES requestMethod:Post requestCompleBlock:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        block(response,responseObject,error);
    }];
    
}
+ (void)hqPut:(NSDictionary *)param url:(NSString *)url complete:(HqHttpUtilResultBlock)block{
    
    [HqAFHttpClient starRequestWithHeaders:nil withURLString:url withParam:param requestIsNeedJson:YES responseIsNeedJson:YES requestMethod:Put requestCompleBlock:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        block(response,responseObject,error);
    }];
    
}
+ (void)hqDelete:(NSDictionary *)param url:(NSString *)url complete:(HqHttpUtilResultBlock)block{
    
    [HqAFHttpClient starRequestWithHeaders:nil withURLString:url withParam:param requestIsNeedJson:YES responseIsNeedJson:YES requestMethod:Delete requestCompleBlock:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        block(response,responseObject,error);
    }];
    
}
+ (void)hqGetShowHudTitle:(NSString *)title param:(NSDictionary *)param url:(NSString *)url complete:(HqHttpUtilResultBlock)block{
    if (!title) {
        title = @"Please wait";
    }
    [SVProgressHUD showWithStatus:title];
    [HqAFHttpClient starRequestWithHeaders:nil withURLString:url withParam:param requestIsNeedJson:YES responseIsNeedJson:YES requestMethod:Get requestCompleBlock:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        block(response,responseObject,error);
        [SVProgressHUD dismiss];
    }];
}

+ (void)hqPostShowHudTitle:(NSString *)title param:(NSDictionary *)param url:(NSString *)url complete:(HqHttpUtilResultBlock)block{
    if (!title) {
        title = @"Please wait";
    }
    [SVProgressHUD showWithStatus:title];
    [HqAFHttpClient starRequestWithHeaders:nil withURLString:url withParam:param requestIsNeedJson:YES responseIsNeedJson:YES requestMethod:Post requestCompleBlock:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        block(response,responseObject,error);
        [SVProgressHUD dismiss];
    }];
}
+ (void)hqPutShowHudTitle:(NSString *)title param:(NSDictionary *)param url:(NSString *)url complete:(HqHttpUtilResultBlock)block{
    if (!title) {
        title = @"Please wait";
    }
    [SVProgressHUD showWithStatus:title];
    [HqAFHttpClient starRequestWithHeaders:nil withURLString:url withParam:param requestIsNeedJson:YES responseIsNeedJson:YES requestMethod:Put requestCompleBlock:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        block(response,responseObject,error);
        [SVProgressHUD dismiss];
    }];
}
+ (void)hqDeleteShowHudTitle:(NSString *)title param:(NSDictionary *)param url:(NSString *)url complete:(HqHttpUtilResultBlock)block{
    if (!title) {
        title = @"Please wait";
    }
    [SVProgressHUD showWithStatus:title];
    [HqAFHttpClient starRequestWithHeaders:nil withURLString:url withParam:param requestIsNeedJson:YES responseIsNeedJson:YES requestMethod:Delete requestCompleBlock:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        block(response,responseObject,error);
        [SVProgressHUD dismiss];
    }];
}

@end
