//
//  HqString.m
//  DaysDemo
//
//  Created by macpro on 16/6/30.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import "HqString.h"


@implementation HqString
- (instancetype)initWithHqString:(NSString *)str{
    if (self = [super init]) {
        _hqAttributedString = [[NSMutableAttributedString alloc]initWithString:str];
        _hqStringLength = str.length;
    }
    return self;
}
//字体
- (void)setHqFont:(UIFont *)hqFont range:(NSRange)range{
    [_hqAttributedString addAttribute:NSFontAttributeName value:hqFont range:range];
}
//字间距
- (void)setWordSpace:(CGFloat)space range:(NSRange)range{
    
     [_hqAttributedString addAttribute:NSKernAttributeName value:@(space) range:range];
}
//背景色
- (void)setHqBackgroundColor:(UIColor *)hqBackgroundColor range:(NSRange)range{
 [_hqAttributedString addAttribute:NSBackgroundColorAttributeName value:hqBackgroundColor range:range];
}
//前景色(相当于字体颜色)
- (void)setHqForegroundColor:(UIColor *)hqForegroundColor range:(NSRange)range{
    [_hqAttributedString addAttribute:NSForegroundColorAttributeName value:hqForegroundColor range:range];
}
//删除线
- (void)setHqStrikethroughColor:(UIColor *)hqStrikethroughColor lineStyle:(NSUnderlineStyle)hqlineStyle range:(NSRange)range{
    [_hqAttributedString addAttribute:NSStrikethroughColorAttributeName value:hqStrikethroughColor range:range];
     [_hqAttributedString addAttribute:NSStrikethroughStyleAttributeName value:@(hqlineStyle) range:range];
}
//下划线
- (void)setHqUnderlineColor:(UIColor *)hqUnderlineColor lineStyle:(NSUnderlineStyle)hqlineStyle range:(NSRange)range{
    [_hqAttributedString addAttribute:NSUnderlineColorAttributeName value:hqUnderlineColor range:range];
    [_hqAttributedString addAttribute:NSUnderlineStyleAttributeName value:@(hqlineStyle) range:range];
}

+ (NSAttributedString *)lineSpace:(CGFloat)space text:(NSString *)labelText{
    if (labelText.length==0) {
        return nil;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, labelText.length)];
    return attributedString;
}
@end
