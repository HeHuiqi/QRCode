//
//  NSString+Public.h
//  VaktenUse
//
//  Created by iMac on 15/7/15.
//  Copyright (c) 2015年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Public)

+ (NSString *)generateSessionId;
#pragma mark - 十六进制转字符 GBK编码
+ (NSString *)stringFromHexString:(NSString *)hexString;
#pragma mark -   二进制转十进制
+ (int)toDecimalSystemWithBinarySystem:(NSString *)binary;

#pragma mark -   十进制转二进制
+ (NSMutableArray *)toBinarySystemWithDecimalSystem:(int)decimal;

+ (CGFloat )getTextHeightWithString:(NSString *)string fontSize:(CGFloat )size textWidth:(CGFloat)width;
- (BOOL)isContainsString:(NSString *)searchString;
+ (NSString *)md5WithString:(NSString *)str;
+ (NSData*)hexStringToNSData:(NSString*)hexString;
@end
