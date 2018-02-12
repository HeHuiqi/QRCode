//
//  HqTransferVC.m
//  QRCode
//
//  Created by macpro on 2018/2/11.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqTransferVC.h"
#import "HqTransferView.h"
#import "HqTransferInfoView.h"
#import "HqTransferSetMoneyVC.h"
#import "HqPayVC.h"

@interface HqTransferVC ()<HqPayVCDelegate>

@property (nonatomic,strong) HqTransferView *transferView;
@property (nonatomic,strong) HqTransferInfoView *transferInfoView;

@end

@implementation HqTransferVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
- (void)dealloc{
    [self.transferView stopGetPayCode];
}
- (void)initView{
    self.title = @"Transfer";
    [self.view addSubview:self.transferView];
    self.view.backgroundColor = AppMainColor;
    [self.transferView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kZoomValue(40)+64);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.mas_equalTo(kZoomValue(400));
    }];
    self.transferView.userName = @"QR";
    if (_pesonTransferType == 2) {
        self.transferView.params = @{
                                     @"transferType": @"passive",
                                     @"pin":_transfer.pin,
                                     @"amount": @(_transfer.amount),
                                     @"currency": @"VND"
                                     };
        self.transferView.transferMoney = _transfer.amount;

    }else{
        self.transferView.params = @{@"transferType": @"active"};

    }
    [self.view addSubview:self.transferInfoView];
    [self.transferInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.transferView.mas_bottom).offset(kZoomValue(30));
        make.left.equalTo(self.view).offset(kZoomValue(15));
        make.right.equalTo(self.view).offset(kZoomValue(-15));
        make.height.mas_equalTo(kZoomValue(40));
    }];
    [self.transferInfoView addTarget:self action:@selector(setPayMoney) forControlEvents:UIControlEventTouchUpInside];
    
    [self.transferView startGetPayCode];
}
- (void)setPayMoney{
    
//    HqPayVC *payVC = [[HqPayVC alloc] init];
//    payVC.transferType = 2;
//    payVC.delegate = self;
//    Push(payVC);
    
    HqTransferSetMoneyVC *setMoneyVC = [[HqTransferSetMoneyVC alloc] init];
    Push(setMoneyVC);
}
- (HqTransferView *)transferView{
    if (!_transferView) {
        _transferView = [[HqTransferView alloc] init];
    }
    return _transferView;
}
- (HqTransferInfoView *)transferInfoView{
    if (!_transferInfoView) {
        _transferInfoView = [[HqTransferInfoView alloc] init];
        _transferInfoView.backgroundColor = [UIColor whiteColor];
    }
    return _transferInfoView;
}
- (void)backClick{
    if (_pesonTransferType == 2) {
        BackRoot();
    }else{
        [super backClick];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - HqPayVCDelegate
- (void)hqPayVC:(HqPayVC *)vc transfer:(HqTransfer *)transfer{
    self.transferView.params = @{
                                 @"transferType": @"passive",
                                 @"pin":transfer.pin,
                                 @"amount": @(transfer.amount),
                                 @"currency": @"VND"
                                 };
    self.transferView.transferMoney = transfer.amount;
    [self.transferView startGetPayCode];
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
