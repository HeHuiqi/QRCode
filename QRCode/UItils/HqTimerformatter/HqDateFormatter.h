//
//  HqTimeFormatter.h
//  iRAIDWear
//
//  Created by macpro on 2017/4/25.
//  Copyright © 2017年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HqDateFormatter : NSObject

@property (nonatomic,strong)NSDateFormatter *dateForMatter;

+ (instancetype)shareInstance;

#pragma mark - 时间戳-->字符串日期
- (NSString *)dateStringWithFormat:(NSString *)format timeInterval:(NSTimeInterval)timeInterval;

#pragma mark - NSDate-->字符串日期
- (NSString *)dateStringWithFormat:(NSString *)format date:(NSDate *)date;

#pragma mark - 字符串日期-->NSDate
- (NSDate *)dateWithFormat:(NSString *)format dateString:(NSString *)dateString;

#pragma mark - 字符串日期-->另一个字符串日期
- (NSString *)dateString:(NSString *)dateString orginalFormat:(NSString *)orginal resultFormat:(NSString *)resultFormat;

@end

@interface HqDateFormatter(HqDateConvert)

#pragma mark - 字符串日期-->另一个字符串日期
+ (NSString *)convertDateString:(NSString *)dateString orginalFormat:(NSString *)orginal resultFormat:(NSString *)resultFormat;
@end


