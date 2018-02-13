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

@interface HqPayVC : SuperVC

@property (nonatomic,copy) NSString *code;
@property (nonatomic,assign) BOOL isFromScan;
@property (nonatomic,strong) HqBill *bill;
@property (nonatomic,strong) HqTransfer *transfer;

@property (nonatomic,assign) NSInteger transferType;//1主动模式作为收款人，2被动模式作为付款人，3商户 
@end
