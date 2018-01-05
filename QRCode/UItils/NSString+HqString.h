//
//  NSString+HqString.h
//  DaysDemo
//
//  Created by macpro on 16/4/15.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface NSString (HqString)

//判断手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (BOOL)checkInputCode:(NSString *)input regex:(NSString *)regex;

#pragma mark - 十六进制字符串转long
+ (unsigned long)hexStrTolong:(NSString *)hexStr;

#pragma mark - data转十六进制字符串
+ (NSString *)convertDataToHexStr:(NSData *)data;

#pragma mark - 十六进制转字符 GBK编码
+ (NSString *)stringFromHexString:(NSString *)hexString;

#pragma mark - 十六进制字符串转换
+ (NSMutableData *)getByteFromStringCommond:(NSString *)commond;


+ (NSDictionary *)getAllPropertiesAndValuesWithClass:(Class)myclass instance:(id)instance;

@end
