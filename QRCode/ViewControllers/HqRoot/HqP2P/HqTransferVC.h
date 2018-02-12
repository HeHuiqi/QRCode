//
//  HqTransferVC.h
//  QRCode
//
//  Created by macpro on 2018/2/11.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "SuperVC.h"

@interface HqTransferVC : SuperVC

@property (nonatomic,assign) NSInteger pesonTransferType;//1主动，2被动
@property (nonatomic,strong) HqTransfer *transfer;

@end


