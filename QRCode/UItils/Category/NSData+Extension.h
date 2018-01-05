//
//  NSData+Extension.h
//  IRaid_R3_SDK
//
//  Created by abc on 2017/6/27.
//  Copyright © 2017年 JackCat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Extension)

/**
 16进制字符串转NSData,不加0x前缀,
 eg: [NSData dataWithHexString:@"FFFF"];
 */
+ (NSData*)dataWithHexString:(NSString*)hexString;

@end
