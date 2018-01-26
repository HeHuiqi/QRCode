//
//  HqPayVC.h
//  QRCode
//
//  Created by macpro on 2018/1/22.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "SuperVC.h"

typedef NS_ENUM(NSInteger,HqTradeType){
    HqTradeTypeTransfer,//转账
    HqTradeTypeScanPay,//扫码
};

@interface HqPayVC : SuperVC

@property (nonatomic,copy) NSString *code;
@property (nonatomic,assign) HqTradeType tradeType;
@property (nonatomic,assign) BOOL isFromScan;
@property (nonatomic,strong) HqBill *bill;


@end
