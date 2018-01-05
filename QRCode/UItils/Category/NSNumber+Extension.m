//
//  NSNumber+Extension.m
//  IRaid_R3_SDK
//
//  Created by abc on 2017/6/27.
//  Copyright © 2017年 JackCat. All rights reserved.
//

#import "NSNumber+Extension.h"

@implementation NSNumber (Extension)

//十六进制字符串转数字
+ (NSInteger)numberWithHexString:(NSString *)hexString{
    const char *hexChar = [hexString cStringUsingEncoding:NSUTF8StringEncoding];
    int hexNumber;
    sscanf(hexChar, "%x", &hexNumber);
    return (NSInteger)hexNumber;
}

@end
