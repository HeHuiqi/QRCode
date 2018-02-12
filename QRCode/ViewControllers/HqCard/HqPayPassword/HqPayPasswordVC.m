//
//  HqPayPasswordVC.m
//  QRCode
//
//  Created by hehuiqi on 2018/1/6.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqPayPasswordVC.h"

#import "HqAddCardVC.h"
#import "HqUserIdInfoVC.h"
@interface HqPayPasswordVC ()

@property (nonatomic,strong) UILabel *infoLab;
@property (nonatomic,strong) HqPassWordView *passwordView;
@property (nonatomic,strong) UIButton *nextBtn;


@end

@implementation HqPayPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVew];
}
- (void)initVew{
    NSString *title = @"";
    NSString *info = @"";
    switch (_payPasswordType) {
        case HqPayPasswordInput:
        {
            title = @"Enter PIN";
            info = @"Enter payment password";
        }
            break;
        case HqPayPasswordCreate:
        {
            title = @"Create PIN";
            info = @"Create payment password";

        }
            break;
        case HqPayPasswordConfirm:
        {
            title = @"Confirm PIN";
            info = @"Confirm payment password";


        }
            break;
            
    }
    self.title = title;
    UIView *contentView = self.view;
    _infoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navBarView.frame)+kZoomValue(30), SCREEN_WIDTH, kZoomValue(13))];
    _infoLab.font = [UIFont systemFontOfSize:kZoomValue(13)];
    _infoLab.text = info;
    _infoLab.textColor = HqGrayColor;
    _infoLab.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:_infoLab];
    
    HqPassWordView *password = [[HqPassWordView alloc] init];
    password.backgroundColor  =[UIColor whiteColor];
    
    CGFloat passwprdHeight = (SCREEN_WIDTH - kZoomValue(40))/6.0;
    password.frame = CGRectMake(kZoomValue(20), CGRectGetMaxY(_infoLab.frame)+kZoomValue(20), passwprdHeight*6.0, passwprdHeight);
    password.passWordNum = 6;
    password.squareWidth = passwprdHeight;
    password.pointRadius = 6;
    password.pointColor = [UIColor blackColor];
    password.rectColor = HqBorderColor;
    [contentView addSubview:password];
    _passwordView = password;
    [_passwordView becomeFirstResponder];
    
    CGFloat space = 20;

    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    nextBtn.tintColor = [UIColor whiteColor];
    if (_payPasswordType == HqPayPasswordConfirm) {
        [nextBtn setTitle:@"Finish" forState:UIControlStateNormal];
    }else{
        [nextBtn setTitle:@"Next" forState:UIControlStateNormal];

    }
    nextBtn.backgroundColor = COLOR(17, 139, 226, 1);
    nextBtn.layer.cornerRadius = kHqCornerRadius;
    [nextBtn addTarget:self action:@selector(passwordNextClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(space));
        make.top.equalTo(password.mas_bottom).offset(kZoomValue(space));
        make.right.equalTo(contentView).offset(-kZoomValue(space));
        make.height.mas_equalTo(kZoomValue(kZoomValue(45)));
    }];
}
- (void)passwordNextClick:(UIButton *)btn{
    [self.view endEditing:YES];
    if (_passwordView.textStore.length != 6) {
        [Dialog toastCenter:@"The payment password invalid"];
        [_passwordView becomeFirstResponder];
        return;
    }
    if (_payPasswordType == HqPayPasswordCreate) {
        HqPayPasswordVC  *confirmVC = [[HqPayPasswordVC alloc] init];
        confirmVC.payPasswordType = HqPayPasswordConfirm;
        confirmVC.lastInpuPayPassword = _passwordView.textStore;
        confirmVC.user = _user;
        confirmVC.isFromAddCardInfo = _isFromAddCardInfo;
        Push(confirmVC);
        return;
    }
    if (_payPasswordType == HqPayPasswordConfirm) {
        if (![_lastInpuPayPassword isEqualToString:_passwordView.textStore]) {
            [Dialog toastCenter:@"Inconsistent input twice"];
            [_passwordView becomeFirstResponder];
        }else{
            NSLog(@"_createPayPassword==%@",_passwordView.textStore);
             [self checkPaypassword];
        }
        return;
    }
    [self checkPaypassword];
//    HqAddCardVC *addCardVC = [[HqAddCardVC alloc] init];
//    addCardVC.user = _user;
//    Push(addCardVC);
}
#pragma mark - 输入支付密码
- (void)checkPaypassword{
    NSString *url = @"/users/pins";
    if (_payPasswordType == HqPayPasswordInput) {
        url = @"/users/pins/checking";
    }
    NSString *pin = [NSString sha1:_passwordView.textStore];
    NSDictionary *param = @{@"pin": pin};
    [HqHttpUtil hqPostShowHudTitle:nil param:param url:url complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                if (_isFromAddCardInfo) {
                    [self backToVC:@"HqCardsVC"];
                }else{
                    if (_user.idNumber.length>0&&_user.realName.length>0) {
                        HqAddCardVC *addCardVC = [[HqAddCardVC alloc] init];
                        addCardVC.user = _user;
                        Push(addCardVC);
                    }else{
                        HqUserIdInfoVC *idUserVC = [[HqUserIdInfoVC alloc] init];
                        Push(idUserVC);
                    }
                }
            }else{
                [_passwordView becomeFirstResponder];
                [Dialog toastCenter:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
}
- (void)backClick{
    if (_isFromAddCardInfo == 1 && _payPasswordType == HqPayPasswordConfirm) {
        [super backClick];
    }else{
        [self backToVC:@"HqCardsVC"];
    }
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
