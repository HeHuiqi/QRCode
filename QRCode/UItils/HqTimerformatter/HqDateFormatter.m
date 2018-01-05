//
//  HqTimeFormatter.m
//  iRAIDWear
//
//  Created by macpro on 2017/4/25.
//  Copyright © 2017年 macpro. All rights reserved.
//

#import "HqDateFormatter.h"

@implementation HqDateFormatter

+ (instancetype)shareInstance{
    static HqDateFormatter *hqtime = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hqtime = [[HqDateFormatter alloc]init];
    });
    return hqtime;
}
#pragma mark - 时间戳-->字符串日期
- (NSString *)dateStringWithFormat:(NSString *)format timeInterval:(NSTimeInterval)timeInterval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    [self.dateForMatter setDateFormat:format];
    NSString *dateStr = [self.dateForMatter stringFromDate:date];
    return dateStr;
}

#pragma mark - NSDate-->字符串日期
- (NSString *)dateStringWithFormat:(NSString *)format date:(NSDate *)date{
    [self.dateForMatter setDateFormat:format];
    NSString *dateStr = [self.dateForMatter stringFromDate:date];
    return dateStr;
}
#pragma mark - 字符串日期-->NSDate
- (NSDate *)dateWithFormat:(NSString *)format dateString:(NSString *)dateString{
    [self.dateForMatter setDateFormat:format];
    NSDate *date = [self.dateForMatter dateFromString:dateString];
    return date;
}
#pragma mark - 字符串日期-->另一个字符串日期
- (NSString *)dateString:(NSString *)dateString orginalFormat:(NSString *)orginal resultFormat:(NSString *)resultFormat{
    [self.dateForMatter setDateFormat:orginal];
    NSDate *date = [self.dateForMatter dateFromString:dateString];
    NSString *dateStr = [self dateStringWithFormat:resultFormat date:date];
    return dateStr;
}

- (NSDateFormatter *)dateForMatter{
    if (!_dateForMatter) {
        _dateForMatter = [[NSDateFormatter alloc]init];
    }
    return _dateForMatter;
}


+ (NSString *)convertDateString:(NSString *)dateString orginalFormat:(NSString *)orginal resultFormat:(NSString *)resultFormat{
    
    return [[HqDateFormatter shareInstance] dateString:dateString orginalFormat:orginal resultFormat:resultFormat];
}
@end
