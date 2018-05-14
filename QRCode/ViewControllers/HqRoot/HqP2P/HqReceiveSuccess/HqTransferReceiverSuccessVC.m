//
//  HqTransferReceiverSuccessVC.m
//  QRCode
//
//  Created by hehuiqi on 2018/5/12.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqTransferReceiverSuccessVC.h"
#import "HqTransferView.h"
@interface HqTransferReceiverSuccessVC ()

@property (nonatomic,strong) HqTransferView *transferView;


@end

@implementation HqTransferReceiverSuccessVC

- (HqTransferView *)transferView{
    if (!_transferView) {
        _transferView = [[HqTransferView alloc] init];
    }
    return _transferView;
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

    //transferType为1
    CGFloat amount = self.bill.amount*-1;
    if (amount>0) {
//        self.transferView.params = @{@"transferType": @"active"};
        self.transferView.title = @"Personal collection";
        self.transferView.titleIconName = @"shou_top_icon";
        self.transferView.subCenterTitle = @"Scan to pay me";
        NSString *str = [NSString stringWithFormat:@"%@paid you%0.2f₫",self.bill.payUser,fabs(amount)];
        self.transferView.productInfo = str;
    }else{
//        self.transferView.params =  @{@"transferType": @"passive"};
        self.transferView.title = @"Personal payment";
        self.transferView.titleIconName = @"fu_top_icon";
        self.transferView.subCenterTitle = @"Scan  to collect from me";
        NSString *user = self.bill.payUser;
        NSString *merchantName = self.bill.merchantName;
        if (user.length==0 || merchantName.length==0) {
            user = @"";
        }
        NSString *str = [NSString stringWithFormat:@"Pay for %@ success",user];
        self.transferView.productInfo = str;
        self.transferView.transferMoney = fabs(amount);

    }
    self.transferView.codeInfo = self.bill.payOrderNo;
    [[NSNotificationCenter defaultCenter] postNotificationName:kPaySuccessNotification object:nil];
}
- (void)backClick{
    Dismiss();
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
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
