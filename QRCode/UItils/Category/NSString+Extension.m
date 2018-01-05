//
//  NSString+Extension.m
//  IRaid_R3_SDK
//
//  Created by abc on 2017/6/24.
//  Copyright © 2017年 JackCat. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

//数字转十六进制字符串
+ (NSString *)hexStringWithNumber:(NSUInteger)hexNumber{
    char hexChar[6];
    sprintf(hexChar, "%x", (int)hexNumber);
    NSString *hexString = [NSString stringWithCString:hexChar encoding:NSUTF8StringEncoding];
    return hexString;
}

#pragma mark - data转十六进制字符串
+ (NSString *)hexStringWithHexData:(NSData *)hexData{
    if (!hexData || [hexData length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[hexData length]];
    
    [hexData enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

@end
