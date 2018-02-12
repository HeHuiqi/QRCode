//
//  ProjectConst.m
//  iRAIDLoop
//
//  Created by macpro on 16/8/2.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import "ProjectConst.h"

@implementation ProjectConst

NSString * const kToken = @"iToken";
NSString * const kisLogin = @"isLogin";
NSString * const kisFirsUse = @"isFirsUse";
NSString * const kUserId = @"UserId";
NSString * const kUserBankCardNumber = @"UserBankCardNumber";
NSString * const kUserPhoneNumber = @"UserPhoneNumber";
NSString * const kAddBankCardSuccess = @"kAddBankCardSuccess";


//            @"^[a-zA-Z0-9_-]{6,16}$" 6-16密码
//            @"^(?=.*[a-zA-Z])(?=.*\\d).{6,16}$" 6-16字符加数字密码
NSString * const kPasswordCheckRegex = @"^[^\\s]{6,16}$";//密码正则匹配



@end
