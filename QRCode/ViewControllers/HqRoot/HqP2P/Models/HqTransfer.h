//
//  HqTransfer.h
//  QRCode
//
//  Created by macpro on 2018/2/11.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HqTransfer : NSObject

@property (nonatomic,copy) NSString *payer;//付款人
@property (nonatomic,copy) NSString *payee;//收款人
@property (nonatomic,assign) NSInteger type;// 1-active, 2-passive
@property (nonatomic,assign) CGFloat amount;//金额
@property (nonatomic,copy) NSString *currency;
@property (nonatomic,copy) NSString *pin;
@property (nonatomic,copy) NSString *code;


//@property (nonatomic,assign) NSInteger status;

@end
