//
//  HqInputView.h
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HqInputView : UITextField

- (instancetype)initWithPlacehoder:(NSString *)placehoder leftText:(NSString *)text;

- (instancetype)initWithPlacehoder:(NSString *)placehoder leftIcon:(NSString *)leftIcon;
- (instancetype)initWithPlacehoder:(NSString *)placehoder;
@end
