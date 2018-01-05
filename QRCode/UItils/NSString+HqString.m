//
//  NSString+HqString.m
//  DaysDemo
//
//  Created by macpro on 16/4/15.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import "NSString+HqString.h"

@implementation NSString (HqString)

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[35678]|18[0-9]|14[57])[0-9]{8}$";
    NSRegularExpression * regular = [[NSRegularExpression alloc]initWithPattern:phoneRegex options:NSRegularExpressionCaseInsensitive error:nil];
    return [regular numberOfMatchesInString:mobileNum options:NSMatchingReportCompletion range:NSMakeRange(0, mobileNum.length)];
}

+ (BOOL)checkInputCode:(NSString *)input regex:(NSString *)regex
{
    NSRegularExpression * regular = [[NSRegularExpression alloc]initWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
    return [regular numberOfMatchesInString:input options:NSMatchingReportCompletion range:NSMakeRange(0, input.length)];
}

#pragma mark - 十六进制字符串转long
+ (unsigned long)hexStrTolong:(NSString *)hexStr{
    char *rest = (char *)[hexStr UTF8String];
    unsigned long sum = 0;
    for (int i = 0; i<hexStr.length; i++) {
        char j[1] = {rest[i]};
        unsigned long k =  strtoul(j,0,16);
        sum = sum + k*powf(16, hexStr.length - i - 1);
    }
    return sum;
}
#pragma mark - data转十六进制字符串
+ (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
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

#pragma mark - 十六进制转字符 GBK编码
+ (NSString *)stringFromHexString:(NSString *)hexString {
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr] ;
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:encode];
    return unicodeString;
}

#pragma mark - 十六进制字符串转换
+ (NSMutableData *)getByteFromStringCommond:(NSString *)commond
{
    NSMutableData *mutableData = [[NSMutableData alloc]init];
    
    const char *buf = [commond UTF8String];
    
    if (buf)
    {
        uint32_t len = (uint32_t)strlen(buf);
        
        char singleNumberString[3] = {'\0', '\0', '\0'};
        uint32_t singleNumber = 0;
        
        for (uint32_t i = 0; i < len; i+=2)
        {
            if ( ((i+1) < len) && isxdigit(buf[i]) && (isxdigit(buf[i+1])) )
            {
                singleNumberString[0] = buf[i];
                singleNumberString[1] = buf[i + 1];
                sscanf(singleNumberString, "%x", &singleNumber);
                uint8_t tmp = (uint8_t)(singleNumber & 0x000000FF);
                [mutableData appendBytes:(void *)(&tmp)length:1];
            }
            else
            {
                break;
            }
        }
    }
    return mutableData;
}
+ (NSDictionary *)getAllPropertiesAndValuesWithClass:(Class)myclass instance:(id)instance{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount;
    //属性的链表
    objc_property_t *properties =class_copyPropertyList(myclass, &outCount);
    //遍历链表
    for (int i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        //获取属性字符串
        const char* propertyName =property_getName(property);
        //转换成NSString
        NSString *key = [NSString stringWithUTF8String:propertyName];
        //获取属性对应的value
        id value = [instance valueForKey:key];
        
    }
    //释放结构体数组内存
    free(properties);
    return props;
}


@end
