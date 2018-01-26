//
//  HqSetLoginPassword.m
//  QRCode
//
//  Created by macpro on 2018/1/8.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqSetLoginPassword.h"
#import "HqInputView.h"
@interface HqSetLoginPassword ()

@property (nonatomic,strong) HqInputView *passwordTf;
@property (nonatomic,strong) HqInputView *confirmPasswordTf;

@end

@implementation HqSetLoginPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Set login password";
    [self initView];
}
- (void)initView{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.isShowBottomLine = YES;
    UIView *contentView = self.view;
    CGFloat inputHeight = 45;
    CGFloat leftSpace = 20;
    
    UILabel *infoLab = [[UILabel alloc] initWithFrame:CGRectMake(kZoomValue(leftSpace), CGRectGetMaxY(self.navBarView.frame)+40, SCREEN_WIDTH-60, kZoomValue(30))];
    infoLab.font = [UIFont systemFontOfSize:kZoomValue(12)];
    infoLab.textAlignment = NSTextAlignmentCenter;
    infoLab.textColor = HqGrayColor;
    infoLab.numberOfLines = 0;
    infoLab.text = @"password must contain at least 6 characters \n including both letters and numbers";
    [contentView addSubview:infoLab];

    _passwordTf = [[HqInputView alloc] initWithPlacehoder:@"Password" leftIcon:@"hqpassword_icon"];
    _passwordTf.secureTextEntry = YES;
    _passwordTf.layer.cornerRadius = kHqCornerRadius;
    [contentView addSubview:_passwordTf];
    
    [_passwordTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
        make.top.equalTo(infoLab.mas_bottom).offset(kZoomValue(leftSpace));
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    
    _confirmPasswordTf = [[HqInputView alloc] initWithPlacehoder:@"Confirm Password" leftIcon:@"hqpassword_icon"];
    _confirmPasswordTf.secureTextEntry = YES;
    _confirmPasswordTf.layer.cornerRadius = kHqCornerRadius;
    [contentView addSubview:_confirmPasswordTf];
    

    [_confirmPasswordTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
        make.top.equalTo(_passwordTf.mas_bottom).offset(kZoomValue(leftSpace));
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    registBtn.tintColor = [UIColor whiteColor];
    [registBtn setTitle:@"Complete" forState:UIControlStateNormal];
    registBtn.backgroundColor = COLOR(17, 139, 226, 1);
    [registBtn addTarget:self action:@selector(registAppComplete:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:registBtn];
    registBtn.layer.cornerRadius = kHqCornerRadius;
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_confirmPasswordTf.mas_bottom).offset(kZoomValue(30));
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
}
- (void)registAppComplete:(UIButton *)btn{
    NSString *password = [NSString sha1:_confirmPasswordTf.text];
    NSDictionary *param = @{@"mobile": _mobile,
                            @"otp": _verficationCode,
                            @"password": password};
    [HqHttpUtil hqPostShowHudTitle:nil param:param url:@"/users" complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                NSString *token = [responseObject hq_objectForKey:@"token"];
                SetUserDefault(token, kToken);
                SetUserDefault(@"1", kisLogin);
                AppDelegate *app = [AppDelegate shareApp];
                app.isInputGesturePassword = YES;
                [AppDelegate setRootVC:HqSetRootVCHome];
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
