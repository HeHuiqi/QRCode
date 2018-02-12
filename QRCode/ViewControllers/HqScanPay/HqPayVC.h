//
//  HqPayVC.h
//  QRCode
//
//  Created by macpro on 2018/1/22.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "SuperVC.h"

//typedef NS_ENUM(NSInteger,HqTradeType){
//    HqTradeTypeTransfer,//转账
//    HqTradeTypeScanPay,//扫码
//};
@protocol HqPayVCDelegate;
@interface HqPayVC : SuperVC

@property (nonatomic,assign) id<HqPayVCDelegate> delegate;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,assign) BOOL isFromScan;
@property (nonatomic,strong) HqBill *bill;
@property (nonatomic,strong) HqTransfer *transfer;

@property (nonatomic,assign) NSInteger transferType;//1个人被动，2个人主动，3商户


@end

@protocol HqPayVCDelegate

- (void)hqPayVC:(HqPayVC *)vc transfer:(HqTransfer *)transfer;

@end

