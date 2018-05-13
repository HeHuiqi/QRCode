//
//  HqTransferReceiverSuccessVC.h
//  QRCode
//
//  Created by hehuiqi on 2018/5/12.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "SuperVC.h"

@interface HqTransferReceiverSuccessVC : SuperVC

//@property (nonatomic,assign) NSInteger transferType;//1表示未设置金额，2设置金额
@property (nonatomic,strong) HqBill *bill;

@end
