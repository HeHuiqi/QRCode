//
//  UIImage+HqImageCategory.h
//  iRAIDLoop
//
//  Created by macpro on 16/9/13.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HqImageCategory)

+ (UIImage *)getScreenshot:(UIView *)view;

+(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

+ (UIImage*) createImageWithColor: (UIColor*) color;
//图片转换为base64
+ (NSString*)base64forData:(NSData*)theData;

@end
