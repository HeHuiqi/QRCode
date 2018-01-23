//
//  HqScanCardVC.h
//  QRCode
//
//  Created by macpro on 2018/1/23.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "SuperVC.h"
@protocol HqScanCardVCDelegate;
@interface HqScanCardVC : SuperVC

@property (nonatomic,assign) id<HqScanCardVCDelegate> delegate;

@end

@protocol HqScanCardVCDelegate

- (void)HqScanCardVC:(HqScanCardVC *)vc cardNumber:(NSString *)cardNumer;
@end
