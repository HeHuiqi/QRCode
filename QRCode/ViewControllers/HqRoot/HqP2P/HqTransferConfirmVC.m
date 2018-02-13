//
//  HqTransferConfirmVC.m
//  QRCode
//
//  Created by hehuiqi on 2018/2/12.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqTransferConfirmVC.h"
#import "HqPaySuccessVC.h"
@interface HqTransferConfirmVC ()<HqConfirmPayViewDelegate>

@property (nonatomic,strong) HqConfirmPayView *confirmPayView;


@end

@implementation HqTransferConfirmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
- (HqConfirmPayView *)confirmPayView{
    
    if (!_confirmPayView) {
        _confirmPayView = [[HqConfirmPayView alloc] init];
        _confirmPayView.delegate = self;
    }
    return _confirmPayView;
}
- (void)initView{
    self.title = @"Transfer";
    CGFloat inputHeight = 45;
    CGFloat leftSpace = 20;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    contentView.layer.borderWidth = 1.0;
    contentView.layer.borderColor = HqBorderColor.CGColor;
    contentView.layer.cornerRadius = kHqCornerRadius;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kZoomValue(leftSpace));
        make.top.equalTo(self.view).offset(kZoomValue(26)+self.navBarheight);
        make.right.equalTo(self.view).offset(-kZoomValue(leftSpace));
        make.height.mas_equalTo(kZoomValue(210));
    }];
    
    UIImageView *userIcon = [[UIImageView alloc] init];
    userIcon.image = [UIImage imageNamed:@"temp_user_icon"];
    [contentView addSubview:userIcon];
    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(contentView).offset(kZoomValue(19));
        make.size.mas_equalTo(CGSizeMake(kZoomValue(64), kZoomValue(64)));
    }];
    
    UILabel *infoLab = [[UILabel alloc] init];
    infoLab.textColor  = COLORA(72,90,101);
    infoLab.text = @"Transfer to individual users";
    [contentView addSubview:infoLab];
    [infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(userIcon.mas_bottom).offset(kZoomValue(13));
    }];
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.textColor  = COLORA(72,90,101);
    nameLab.font =[UIFont systemFontOfSize:kZoomValue(12)];
    nameLab.text = _transfer.payee;
    [contentView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(infoLab.mas_bottom).offset(kZoomValue(9));
    }];
    
    UILabel *moneyLab = [[UILabel alloc] init];
    moneyLab.textColor  = COLORA(72,90,101);
    moneyLab.font =[UIFont systemFontOfSize:kZoomValue(30)];
    moneyLab.text = [NSString stringWithFormat:@"₫ %.2f",_transfer.amount];
    [contentView addSubview:moneyLab];
    [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(nameLab.mas_bottom).offset(kZoomValue(24));
    }];
    
    UIButton *transferBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    transferBtn.tintColor = [UIColor whiteColor];
    [transferBtn setTitle:@"Transfer" forState:UIControlStateNormal];
    transferBtn.backgroundColor = COLOR(17, 139, 226, 1);
    [transferBtn addTarget:self action:@selector(transfer:) forControlEvents:UIControlEventTouchUpInside];
    transferBtn.layer.cornerRadius = kHqCornerRadius;
    [self.view addSubview:transferBtn];
    
    [transferBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kZoomValue(leftSpace));
        make.top.equalTo(contentView.mas_bottom).offset(kZoomValue(15));
        make.right.equalTo(self.view).offset(-kZoomValue(leftSpace));
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
}
- (void)transfer:(UIButton *)btn{
    [self.confirmPayView showPayView];
    
}
#pragma mark - HqConfirmPayViewDelegate
- (void)hqConfirmPayView:(HqConfirmPayView *)payView password:(NSString *)password{
    
    [payView dismissPayView];
    NSLog(@"password == %@",password);
    password = [NSString sha1:password];
    NSLog(@"password1 == %@",password);
    
    
    /*
   NSDictionary *param = @{
              @"transferCode": _transfer.code,
              @"pin": password,
              @"amount":@(_transfer.amount),
              @"currency": @"VND"
              };
    NSString *url = @"/transactions/transfers/complete";
    */
    _transfer.pin = password;
    [HqScanPayUtil confirmTransfer:_transfer code:_transfer.code vc:self complete:^(BOOL result) {
        
    }];
    
    /*
    [HqHttpUtil hqPostShowHudTitle:nil param:param url:url complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"支付结果==%@",responseObject);
        
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                HqPaySuccessVC *paySuccess = [[HqPaySuccessVC alloc] init];
                Push(paySuccess);
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
    */
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
