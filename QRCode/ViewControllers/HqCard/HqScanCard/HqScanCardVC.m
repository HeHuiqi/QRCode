//
//  HqScanCardVC.m
//  QRCode
//
//  Created by macpro on 2018/1/23.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqScanCardVC.h"
#import <CardIO/CardIO.h>
@interface HqScanCardVC ()<CardIOPaymentViewControllerDelegate>

@end

@implementation HqScanCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tapView:self.view];
}
- (void)tapView:(UIView *)view{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [view addGestureRecognizer:tap];
}
- (void)tapGesture:(UITapGestureRecognizer *)tap{
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    scanViewController.disableManualEntryButtons = YES;//不显示右边按钮
    scanViewController.suppressScanConfirmation = YES;//立即返回
    // 进行简单的设置
    scanViewController.hideCardIOLogo = YES;
    scanViewController.collectCVV = NO;
    scanViewController.collectExpiry = NO;
    [self presentViewController:scanViewController animated:YES completion:nil];
}
#pragma mark - CardIOPaymentViewControllerDelegate
- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController{
     [paymentViewController dismissViewControllerAnimated:YES completion:nil];
}
- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)cardInfo inPaymentViewController:(CardIOPaymentViewController *)paymentViewController{
    //扫描结果
//    NSLog(@"Received card info. Number: %@, expiry: %02ld/%ld, cvv: %@-%@", cardInfo.cardNumber, (unsigned long)cardInfo.expiryMonth, (unsigned long)cardInfo.expiryYear, cardInfo.cvv);
    NSLog(@"cardNumber == %@",cardInfo.cardNumber);
    // 这里可以自己进行一些处理
    ///
    [paymentViewController dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
