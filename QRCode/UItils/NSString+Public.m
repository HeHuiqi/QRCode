//
//  NSString+Public.m
//  VaktenUse
//
//  Created by iMac on 15/7/15.
//  Copyright (c) 2015年 iMac. All rights reserved.
//

#import "NSString+Public.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Public)

#pragma mark - 随机生成SessionID
+ (NSString *)generateSessionId
{
    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
    return [self String2Md5:[NSString stringWithFormat:@"%fXWF%ld", timestamp, random() % 9999]];
}
+ (NSString *)String2Md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}
+ (CGFloat )getTextHeightWithString:(NSString *)string fontSize:(CGFloat )size textWidth:(CGFloat)width
{
    CGSize contentSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:size]} context:nil].size;
    return contentSize.height;
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
    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;
}
#pragma mark -   二进制转十进制
+ (int)toDecimalSystemWithBinarySystem:(NSString *)binary
{
    int ll = 0 ;
    int  temp = 0 ;
    for (int i = 0; i < binary.length; i ++)
    {
        temp = [[binary substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(2, binary.length - i - 1);
        ll += temp;
    }
    
    return ll;
}
#pragma mark -   十进制转二进制
+ (NSMutableArray *)toBinarySystemWithDecimalSystem:(int)decimal
{
    NSMutableArray *resultArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    if (decimal == 0) {
        return nil;
    }
    int num = decimal;
    int remainder = 0;      //余数
    int divisor = 0;        //除数
    NSString * prepare = @"";
    
    while (true)
    {
        remainder = num%2;
        divisor = num/2;
        num = divisor;
        prepare = [prepare stringByAppendingFormat:@"%d",remainder];
        [resultArray addObject:[NSNumber numberWithInt:remainder]];
        if (divisor == 0)
        {
            break;
        }
    }
    return resultArray;
}
+ (NSString *)md5WithString:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}
- (BOOL)isContainsString:(NSString *)searchString{
    
    if (strstr([self UTF8String], [searchString UTF8String])) {
        return YES;
    }
    
    return NO;
}
+ (NSData*)hexStringToNSData:(NSString*)hexString{
    if (!hexString){
        return [NSData data];
    }
    
    //栈缓冲区
    Byte stackBuffer[512];
    Byte *buffer;
    uint bufferLength = (uint)hexString.length / 2 + hexString.length % 2 ;
    
    if (bufferLength > sizeof(stackBuffer)) {
        //当字符串长度大于栈缓冲区时，使用堆内存
        buffer = (Byte*)malloc(bufferLength);
    }
    else{
        buffer = stackBuffer;
    }
    
    NSUInteger length = hexString.length;
    
    for (NSUInteger i = 0; i<length; i++) {
        unichar c = [hexString characterAtIndex:i];
        if (i & 0x1){
            //低四位（后处理）
            buffer[i >> 1] |= c & 0x0F;
        }
        else{
            //高四位（先处理）
            buffer[i >> 1] = c << 4;
        }
    }
    
    NSData *result = [NSData dataWithBytes:buffer length:bufferLength];
    
    if (buffer != stackBuffer) {
        //当字符串长度大于栈缓冲区时使用的是堆内存，在这里释放
        free(buffer);
    }
    
    return result;
}
@end
