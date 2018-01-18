//
//  HqCardDetailVC.h
//  QRCode
//
//  Created by macpro on 2018/1/16.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "SuperVC.h"

typedef NS_ENUM(NSUInteger, HqCardOperate) {
    HqCardOperateSetDetault,
    HqCardOperateDelete,
};
@protocol HqCardDetailVCDelegate;
@interface HqCardDetailVC : SuperVC

@property (nonatomic,strong) HqBankCard *bankCard;
@property (nonatomic,assign) id<HqCardDetailVCDelegate> delegate;

@end

@protocol HqCardDetailVCDelegate

- (void)hqCardDetailVC:(HqCardDetailVC *)vc cardOperate:(HqCardOperate)operate;

@end
