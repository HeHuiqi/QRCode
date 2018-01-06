//
//  HqPayPasswordVC.h
//  QRCode
//
//  Created by hehuiqi on 2018/1/6.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "SuperVC.h"

typedef NS_ENUM(NSUInteger, HqPayPasswordType) {
    HqPayPasswordCreate,
    HqPayPasswordConfirm,
    HqPayPasswordInput,
};

@interface HqPayPasswordVC : SuperVC

@property (nonatomic,assign) HqPayPasswordType payPasswordType;

@end
