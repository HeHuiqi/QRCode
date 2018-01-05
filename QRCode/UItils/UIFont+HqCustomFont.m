//
//  UIFont+HqCustomFont.m
//  iRAIDLoop
//
//  Created by macpro on 2016/10/18.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import "UIFont+HqCustomFont.h"
#import <CoreText/CoreText.h>
@implementation UIFont (HqCustomFont)

+ (UIFont*)customFontWithPath:(NSString*)path size:(CGFloat)size
{
    NSURL *fontUrl = [NSURL fileURLWithPath:path];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(fontRef, NULL);
    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
    UIFont *font = [UIFont fontWithName:fontName size:size];
    CGFontRelease(fontRef);
    return font;
}

@end
