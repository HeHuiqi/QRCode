//
//  HqHttpUtil.h
//  QRCode
//
//  Created by macpro on 2018/1/8.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HqHttpUtilResultBlock) (NSHTTPURLResponse *response, id responseObject,NSError *error);

@interface HqHttpUtil : NSObject

+ (void)hqPost:(NSDictionary *)param url:(NSString *)url complete:(HqHttpUtilResultBlock)block;
+ (void)hqGet:(NSDictionary *)param url:(NSString *)url complete:(HqHttpUtilResultBlock)block;
+ (void)hqPut:(NSDictionary *)param url:(NSString *)url complete:(HqHttpUtilResultBlock)block;
+ (void)hqDelete:(NSDictionary *)param url:(NSString *)url complete:(HqHttpUtilResultBlock)block;


+ (void)hqGetShowHudTitle:(NSString *)title param:(NSDictionary *)param url:(NSString *)url complete:(HqHttpUtilResultBlock)block;
+ (void)hqPostShowHudTitle:(NSString *)title param:(NSDictionary *)param url:(NSString *)url complete:(HqHttpUtilResultBlock)block;
+ (void)hqPutShowHudTitle:(NSString *)title param:(NSDictionary *)param url:(NSString *)url complete:(HqHttpUtilResultBlock)block;
+ (void)hqDeleteShowHudTitle:(NSString *)title param:(NSDictionary *)param url:(NSString *)url complete:(HqHttpUtilResultBlock)block;

@end
