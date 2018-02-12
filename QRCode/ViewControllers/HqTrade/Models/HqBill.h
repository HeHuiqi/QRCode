//
//  HqBill.h
//  QRCode
//
//  Created by macpro on 2018/1/19.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HqBill : NSObject

@property (nonatomic,copy) NSString *merchantName;//商户名
@property (nonatomic,copy) NSString *payCreateTime;
@property (nonatomic,copy) NSString *payUser;//支付用户名
@property (nonatomic,copy) NSString *payProduct;//消费产品名称
@property (nonatomic,copy) NSString *payOrderNo;//订单号吗
@property (nonatomic,assign) double payTime;//支付时间
@property (nonatomic,assign) float amount;//消费金额
@property (nonatomic,copy) NSString *collectCode;
@property (nonatomic,assign) NSInteger status;//1支出，2收入
@property (nonatomic,copy) NSString *currency;//货币种类

@end
