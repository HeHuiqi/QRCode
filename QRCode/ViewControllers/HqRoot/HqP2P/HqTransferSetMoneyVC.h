//
//  HqTransferSetMoneyVC.h
//  QRCode
//
//  Created by macpro on 2018/2/11.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "SuperVC.h"
@protocol HqTransferSetMoneyVCDelegate;
@interface HqTransferSetMoneyVC : SuperVC

@property (nonatomic,assign) id<HqTransferSetMoneyVCDelegate> delegate;

@property (nonatomic,strong) HqTransfer *transfer;
@property (nonatomic,assign) NSInteger transferType;//1主动模式作为收款人，2被动模式作为付款人，3商户

@end


@protocol HqTransferSetMoneyVCDelegate
- (void)hqTransferSetMoneyVC:(HqTransferSetMoneyVC *)vc transfer:(HqTransfer *)transfer;
@end
