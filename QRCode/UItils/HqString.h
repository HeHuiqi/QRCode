//
//  HqString.h
//  DaysDemo
//
//  Created by macpro on 16/6/30.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HqString : NSObject


- (instancetype)initWithHqString:(NSString *)str;

@property (nonatomic,strong) NSMutableAttributedString *hqAttributedString;
@property (nonatomic,assign,readonly) NSUInteger hqStringLength;
//字体
- (void)setHqFont:(UIFont *)hqFont range:(NSRange)range;
//字间距
- (void)setWordSpace:(CGFloat)space range:(NSRange)range;
//背景色
- (void)setHqBackgroundColor:(UIColor *)hqBackgroundColor range:(NSRange)range;
//前景色(相当于字体颜色)
- (void)setHqForegroundColor:(UIColor *)hqForegroundColor range:(NSRange)range;

//删除线
- (void)setHqStrikethroughColor:(UIColor *)hqStrikethroughColor lineStyle:(NSUnderlineStyle)hqlineStyle range:(NSRange)range;
//下划线
- (void)setHqUnderlineColor:(UIColor *)hqUnderlineColor lineStyle:(NSUnderlineStyle)hqlineStyle range:(NSRange)range;
//行间距
+ (NSAttributedString *)lineSpace:(CGFloat)space text:(NSString *)labelText;



@end

//使用方法
/*
 HqString *hqStr = [[HqString alloc]initWithHqString:@"现价 ¥98  原价 ¥110"];
 NSRange range = NSMakeRange(0, 6);
 [hqStr setHqForegroundColor:[UIColor greenColor] range:range];
 [hqStr setHqFont:[UIFont systemFontOfSize:17.0] range:range];
 
 NSRange range1 = NSMakeRange(11, hqStr.hqStringLength-11);
 [hqStr setHqStrikethroughColor:[UIColor lightGrayColor] lineStyle:NSUnderlineStyleSingle range:range1];
 
 UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10,80, self.view.bounds.size.width, 30)];
 lab.font = [UIFont systemFontOfSize:15.0];
 lab.textColor = [UIColor lightGrayColor];
 lab.attributedText = hqStr.hqAttributedString;
 [self.view addSubview:lab];
 
 */

