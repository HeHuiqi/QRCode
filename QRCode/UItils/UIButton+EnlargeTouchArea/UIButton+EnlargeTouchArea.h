//
//  NSObject+EnlargeTouchArea.h
//  Button
//
//  Created by messi on 16/12/15.
//  Copyright © 2016年 messi. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIButton (EnlargeTouchArea)

- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat) bottom left:(CGFloat)left;

@end
