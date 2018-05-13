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


@interface HqTransferVC ()<HqTransferSetMoneyVCDelegate>

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
    make.top.equalTo(self.view).offset(kZoomValue(28)+self.navBarheight);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.mas_equalTo(kZoomValue(400));
    }];

    
    [self.view addSubview:self.transferInfoView];
    [self.transferInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.transferView.mas_bottom).offset(kZoomValue(15));
        make.left.equalTo(self.view).offset(kZoomValue(15));
        make.right.equalTo(self.view).offset(kZoomValue(-15));
        make.height.mas_equalTo(kZoomValue(40));
    }];
    [self.transferInfoView addTarget:self action:@selector(setPayMoney) forControlEvents:UIControlEventTouchUpInside];
    self.transferInfoView.backgroundColor = COLOR(255,255,255,0.3);
    self.transferInfoView.titleLab.textColor = [UIColor whiteColor];
    self.transferInfoView.layer.cornerRadius = kHqCornerRadius;

    //transferType为1
    self.transferView.params = @{@"transferType": @"active"};
    self.transferView.title = @"Personal collection";
    self.transferView.titleIconName = @"shou_top_icon";
    self.transferView.subCenterTitle = @"Scan to pay me";
    self.transferInfoView.titleLab.text = @"Personal payment";
    self.transferInfoView.leftIcon.image = [UIImage imageNamed:@"fu_bottom_icon"];
    
    [self.transferView startGetPayCode];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccess) name:kPaySuccessNotification object:nil];
}
- (void)paySuccess{
    BackRoot();
}
- (void)setPayMoney{

   
    HqTransferSetMoneyVC *setMoneyVC = [[HqTransferSetMoneyVC alloc] init];
    setMoneyVC.delegate = self;
    setMoneyVC.transferType = 2;
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
#pragma mark - HqTransferSetMoneyVCDelegate
- (void)hqTransferSetMoneyVC:(HqTransferSetMoneyVC *)vc transfer:(HqTransfer *)transfer{
     //transferType为2
    self.transferView.params = @{
                                 @"transferType": @"passive",
                                 @"pin":transfer.pin,
                                 @"amount": @(transfer.amount),
                                 @"currency":transfer.currency
                                 };
    
    self.transferView.title = @"Personal payment";
    self.transferView.titleIconName = @"fu_top_icon";
    self.transferView.subCenterTitle = @"Scan  to collect from me";
    
    self.transferInfoView.titleLab.text = @"Personal collection ";
    self.transferInfoView.leftIcon.image = [UIImage imageNamed:@"shou_bottom_icon"];
    self.transferView.money = transfer.amount;
    
    [self.transferView stopGetPayCode];
    [self.transferView startGetPayCode];
    
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
