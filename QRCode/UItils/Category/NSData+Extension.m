//
//  NSData+Extension.m
//  IRaid_R3_SDK
//
//  Created by abc on 2017/6/27.
//  Copyright © 2017年 JackCat. All rights reserved.
//

#import "NSData+Extension.h"

@implementation NSData (Extension)

/**
 16进制字符串转NSData,不加0x前缀,
 eg: [NSData dataWithHexString:@"FFFF"];
 */
+ (NSData*)dataWithHexString:(NSString*)hexString {
    if (!hexString || [hexString length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([hexString length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [hexString length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [hexString substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

@end
