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
@property (nonatomic,strong) HqUser *user;
@property (nonatomic,strong) NSString *lastInpuPayPassword;//上次输入的密码

@property (nonatomic,assign) int isFromAddCardInfo;

@end
