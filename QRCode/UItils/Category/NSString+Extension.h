//
//  NSString+Extension.h
//  IRaid_R3_SDK
//
//  Created by abc on 2017/6/24.
//  Copyright © 2017年 JackCat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

//数字转十六进制字符串
+ (NSString *)hexStringWithNumber:(NSUInteger)hexNumber;
#pragma mark - data转十六进制字符串
+ (NSString *)hexStringWithHexData:(NSData *)hexData;

@end
