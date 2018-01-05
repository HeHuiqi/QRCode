//
//  NSNumber+Extension.h
//  IRaid_R3_SDK
//
//  Created by abc on 2017/6/27.
//  Copyright © 2017年 JackCat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Extension)

//十六进制字符串转数字
+ (NSInteger)numberWithHexString:(NSString *)hexString;

@end
