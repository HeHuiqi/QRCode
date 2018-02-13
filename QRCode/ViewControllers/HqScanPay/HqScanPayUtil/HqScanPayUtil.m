//
//  HqScanPayUtil.m
//  QRCode
//
//  Created by hehuiqi on 2018/2/12.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqScanPayUtil.h"
#import "HqPayVC.h"
#import "HqScanResultVC.h"
#import "HqScanTransferResultVC.h"
#import "HqTransferSetMoneyVC.h"
@implementation HqScanPayUtil

#pragma mark - 扫码成功
+ (void)scanSuccess:(NSString *)resultCode vc:(UIViewController *)vc comcompleteplet:(void(^)(BOOL result))complete{
    
    NSDictionary *param = nil;
    NSString *url = nil;
    // hQVDUFY 个人码
    //0002010 商户码
    //hQVUQ0E 主动模式码
    //hQVUQ1A 被动模式码
    NSInteger transferType = 3;// 1主动，2被动 3商户
    if ([resultCode hasPrefix:@"0002010"]) {
        param = @{@"collectCode": resultCode};
        url = @"/transactions/collectCodes/getOrder";
    }else if ([resultCode hasPrefix:@"hQVUQ0E"]){
        //主动模式码
        transferType = 1;
        url = @"/transactions/transfers/getInfo";
        param = @{@"transferCode": resultCode};
    }else if ([resultCode hasPrefix:@"hQVUQ1A"]){
        //被动模式码
        transferType = 2;
        url = @"/transactions/transfers/getInfo";
        param = @{@"transferCode": resultCode};
    }else{
        
    }
    [HqHttpUtil hqPostShowHudTitle:nil param:param url:url complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"获取订单信息==%@",responseObject);
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                if (transferType == 1) {
                    NSDictionary *dataDic = [responseObject hq_objectForKey:@"data"];
                    HqTransfer *transfer = [HqTransfer mj_objectWithKeyValues:dataDic];
                    transfer.code = resultCode;
                    HqTransferSetMoneyVC *setMoneyVC = [[HqTransferSetMoneyVC alloc] init];
                    setMoneyVC.transfer = transfer;
                    
                    setMoneyVC.transferType = transferType;
//                    Push(setMoneyVC);
                    [vc.navigationController pushViewController:setMoneyVC animated:YES];
                    if (complete) {
                        complete(YES);
                    }

                    /*
                     HqPayVC *payVC = [[HqPayVC alloc] init];
                     payVC.code = resultCode;
                     payVC.isFromScan = 1;
                     payVC.transfer = transfer;
                     payVC.transferType = transferType;
                     Push(payVC);
                     */
                    
                } else if (transferType == 2){
                    NSDictionary *dataDic = [responseObject hq_objectForKey:@"data"];
                    HqTransfer *transfer = [HqTransfer mj_objectWithKeyValues:dataDic];
                    [self confirmTransfer:transfer code:resultCode vc:vc complete:complete];
                }
                else{
                    NSDictionary *orderDic = [responseObject hq_objectForKey:@"orderInfo"];
                    HqBill *bill = [HqBill mj_objectWithKeyValues:orderDic];
                    HqPayVC *payVC = [[HqPayVC alloc] init];
                    payVC.code = resultCode;
                    payVC.isFromScan = 1;
                    payVC.transferType = transferType;
                    payVC.bill = bill;
                    [vc.navigationController pushViewController:payVC animated:YES];
                    if (complete) {
                        complete(YES);
                    }
                }
            }else{
                [Dialog simpleToast:msg];
                HqScanResultVC *resultVC = [[HqScanResultVC alloc] init];
                resultVC.result = resultCode;
                [vc.navigationController pushViewController:resultVC animated:YES];
                if (complete) {
                    complete(YES);
                }            }
        }else{
            [Dialog simpleToast:kRequestError];
            if (complete) {
                complete(NO);
            }
        }
    }];
}

+ (void)confirmTransfer:(HqTransfer *)transfer code:(NSString *)code vc:(UIViewController *)vc complete:(void(^)(BOOL result))complete{
    NSDictionary *param = nil;
    NSString *url = @"/transactions/transfers/complete";
    if (transfer.type == 1) {
        param = @{
                  @"transferCode": code,
                  @"amount":@(transfer.amount),
                  @"pin":transfer.pin,
                  @"currency": @"VND"
                  };
    }else{
        param = @{
                  @"transferCode": code,
                  @"amount":@(transfer.amount),
                  @"currency": @"VND"
                  };
    }
    
    [HqHttpUtil hqPostShowHudTitle:nil param:param url:url complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"支付结果==%@",responseObject);
        
        if (response.statusCode == 200) {
            //            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            HqScanTransferResultVC *resultVC = [[HqScanTransferResultVC alloc] init];
            NSDictionary *dataDic = [responseObject hq_objectForKey:@"data"];
           HqTransfer *resultTransfer = [HqTransfer mj_objectWithKeyValues:dataDic];
            if (code==1) {
                resultVC.transferStatus = 1;
                
            }else{
                resultVC.transferStatus = 0;
            }
            resultVC.transfer = resultTransfer;
            [vc.navigationController pushViewController:resultVC animated:YES];
            if (complete) {
                complete(YES);
            }
        }else{
            [Dialog simpleToast:kRequestError];
            if (complete) {
                complete(NO);
            }        }
    }];
}@end
