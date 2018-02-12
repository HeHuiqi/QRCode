//
//  HqUser.h
//  QRCode
//
//  Created by macpro on 2018/1/16.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HqUser : NSObject

@property (nonatomic,copy) NSString *bankName;
@property (nonatomic,copy) NSString *realName;//持卡人姓名
@property (nonatomic,assign) BOOL hasPin;//是否设置支付密码
@property (nonatomic,assign) BOOL hasGesture;//是否设置手势密码
@property (nonatomic,copy) NSString *idNumber;//证件号码
@property (nonatomic,assign) NSInteger idType;//证件类型

@end
