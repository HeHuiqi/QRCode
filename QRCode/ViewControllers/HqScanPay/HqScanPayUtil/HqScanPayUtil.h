//
//  HqScanPayUtil.h
//  QRCode
//
//  Created by hehuiqi on 2018/2/12.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HqScanPayUtil : NSObject

+ (void)scanSuccess:(NSString *)resultCode vc:(UIViewController *)vc comcompleteplet:(void(^)(BOOL result))complete;

+ (void)confirmTransfer:(HqTransfer *)transfer code:(NSString *)code vc:(UIViewController *)vc complete:(void(^)(BOOL result))complete;

@end
