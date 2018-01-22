//
//  HqPayVC.m
//  QRCode
//
//  Created by macpro on 2018/1/22.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqPayVC.h"
#import "HqInputView.h"
@interface HqPayVC ()

@property (nonatomic,strong) UIImageView *userPhoto;
@property (nonatomic,strong) UILabel *userNamelab;
@property (nonatomic,strong) UITextField *amountInput;
@property (nonatomic,strong) HqInputView *markInput;

@end

@implementation HqPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
- (void)initView{
    self.title = @"Transfer Accounts";
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navBarView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    contentView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-64);
    [self.view addSubview:contentView];
    
    UIImageView *userPhoto = [[UIImageView alloc] init];
    [contentView addSubview:userPhoto];
    
    userPhoto.backgroundColor = [UIColor blueColor];
    userPhoto.layer.cornerRadius = kZoomValue(64)/2.0;
    [userPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(contentView).offset(kZoomValue(50));
        make.size.mas_equalTo(CGSizeMake(kZoomValue(64), kZoomValue(64)));
    }];
    self.userPhoto = userPhoto;
    
    UILabel *userNamelab = [[UILabel alloc] init];
    userNamelab.font = [UIFont systemFontOfSize:13];
    userNamelab.text = @"哈哈";
    [contentView addSubview:userNamelab];
    [userNamelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(userPhoto.mas_bottom).offset(kZoomValue(14));
    }];
    self.userNamelab = userNamelab;
    
    UIView *payView = [[UIView alloc] init];
    payView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:payView];
    payView.layer.cornerRadius = 4.0;
    CGFloat payWidth = SCREEN_WIDTH-(kZoomValue(15)*2);
    [payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userNamelab.mas_top).offset(kZoomValue(44));
        make.left.equalTo(contentView).offset(kZoomValue(15));
        make.size.mas_equalTo(CGSizeMake(payWidth, kZoomValue(164)));
    }];
   
    UILabel *accountInfoLab = [[UILabel alloc] init];
    accountInfoLab.font = [UIFont systemFontOfSize:15];
    accountInfoLab.text = @"Account";
    [payView addSubview:accountInfoLab];
    [accountInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(payView).offset(kZoomValue(14));
        make.top.equalTo(payView).offset(kZoomValue(30));
    }];
    
    UILabel *moneyLab = [[UILabel alloc] init];
    moneyLab.text = @"₫";
    moneyLab.font = [UIFont systemFontOfSize:kZoomValue(30)];
    [payView addSubview:moneyLab];
    
    
    UITextField *amountInput = [[UITextField alloc] init];
    amountInput.font = [UIFont systemFontOfSize:kZoomValue(40)];
    amountInput.borderStyle = UITextBorderStyleNone;
    amountInput.placeholder = @"Please input money";
    amountInput.keyboardType = UIKeyboardTypeDecimalPad;
    [payView addSubview:amountInput];
    
    [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(payView).offset(kZoomValue(14));
        make.centerY.equalTo(amountInput.mas_centerY).offset(0);
    }];
    amountInput.leftView = moneyLab;
    amountInput.leftViewMode = UITextFieldViewModeAlways;
    [amountInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(accountInfoLab.mas_top).offset(kZoomValue(30));
        make.left.equalTo(moneyLab.mas_left).offset(0);
        make.right.equalTo(payView).offset(-kZoomValue(14));
        make.height.mas_equalTo(kZoomValue(60));
    }];
    self.amountInput = amountInput;

    UIView *xline = [[UIView alloc] init];
    xline.backgroundColor = LineColor;
    [payView addSubview:xline];
    [xline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(payView).offset(kZoomValue(0));
        make.top.equalTo(amountInput.mas_bottom).offset(kZoomValue(2));
        make.right.equalTo(payView).offset(0);
        make.height.mas_equalTo(LineHeight);
    }];
    HqInputView *markInput = [[HqInputView alloc] initWithPlacehoder:@"Add remarks"];
    markInput.font = [UIFont systemFontOfSize:12];
    [payView addSubview:markInput];
    [markInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(payView).offset(0);
        make.top.equalTo(xline.mas_top).offset(kZoomValue(1));
        make.right.equalTo(payView).offset(-kZoomValue(14));
        make.bottom.equalTo(payView).offset(kZoomValue(-2));
    }];
    self.markInput = markInput;
 
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    payBtn.tintColor = [UIColor whiteColor];
    [payBtn setTitle:@"Confirm" forState:UIControlStateNormal];
    payBtn.backgroundColor = COLOR(17, 139, 226, 1);
    [payBtn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:payBtn];
    
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(15));
        make.top.equalTo(payView.mas_bottom).offset(kZoomValue(30));
        make.size.mas_equalTo(CGSizeMake(payWidth, kZoomValue(45)));
    }];
    
//    [self getOrderInfo];
    
}
- (void)pay:(UIButton *)btn{
    
}
- (void)getOrderInfo{
    NSDictionary *param = @{@"collectCode": _code};
    [HqHttpUtil hqPostShowHudTitle:nil param:param url:@"/transactions/collectCodes/getOrder" complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"获取订单信息==%@",responseObject);
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                NSDictionary *orderDic = [responseObject hq_objectForKey:@"orderInfo"];
                HqBill *bill = [HqBill mj_objectWithKeyValues:orderDic];
//                [_userPhoto sd_setImageWithURL:nil placeholderImage:nil]
                _userNamelab.text = bill.merchantName;
                _amountInput.text = [NSString stringWithFormat:@"%0.2f",bill.amount];
                
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
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
