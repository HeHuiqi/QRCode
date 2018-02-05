//
//  LoginVC.m
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "LoginVC.h"
#import "HqInputView.h"

@interface LoginVC ()<UITextFieldDelegate>

@property (nonatomic,strong) HqInputView *mobileTf;
@property (nonatomic,strong) HqInputView *passwordTf;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORA(205, 234, 248);
    [self initView];
    
    
}
- (void)initView{
    UIView *contentView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:contentView];
    
    UIImageView *loginloginLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_bg"]];
    loginloginLogo.contentMode = UIViewContentModeScaleAspectFill;
    [contentView addSubview:loginloginLogo];
    [loginloginLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(0);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(-kZoomValue(43));
        make.height.mas_equalTo(kZoomValue(391));
    }];
    
    UIImageView *loginLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
    loginLogo.contentMode = UIViewContentModeScaleAspectFill;
    [contentView addSubview:loginLogo];
    [loginLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(kZoomValue(161));
        make.centerX.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(kZoomValue(118), kZoomValue(116)));
    }];
    
    CGFloat inputHeight = 45;
    CGFloat leftSpace = 20;
    
    
    _mobileTf = [[HqInputView alloc] initWithPlacehoder:@"Phone number" leftIcon:@"hqphone_icon"];
    _mobileTf.delegate = self;
    _mobileTf.keyboardType = UIKeyboardTypeNumberPad;
    _mobileTf.layer.cornerRadius = kHqCornerRadius;
    [contentView addSubview:_mobileTf];
    
    _passwordTf = [[HqInputView alloc] initWithPlacehoder:@"Password" leftIcon:@"hqpassword_icon"];
    _passwordTf.delegate = self;
    _passwordTf.secureTextEntry = YES;
    _passwordTf.layer.cornerRadius = kHqCornerRadius;

    [contentView addSubview:_passwordTf];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.tintColor = [UIColor whiteColor];
    [loginBtn setTitle:@"Log In" forState:UIControlStateNormal];
    loginBtn.backgroundColor = COLOR(17, 139, 226, 1);
    [loginBtn addTarget:self action:@selector(loginApp:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.layer.cornerRadius = kHqCornerRadius;
    [contentView addSubview:loginBtn];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.bottom.equalTo(contentView).offset(-kZoomValue(100));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    NSString *title = @"Forgot password?";
    UIColor *titleColor = [UIColor darkTextColor];
    HqString *str = [[HqString alloc] initWithHqString:title];
    [str setHqUnderlineColor:titleColor lineStyle:NSUnderlineStyleSingle range:NSMakeRange(0, title.length)];
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    forgetBtn.tintColor = titleColor;
    [forgetBtn setAttributedTitle:str.hqAttributedString forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgotPassword:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:forgetBtn];
    
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.top.equalTo(loginBtn.mas_bottom).offset(kZoomValue(20));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
        make.height.mas_equalTo(kZoomValue(leftSpace));
    }];
    
    
    [_passwordTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
        make.bottom.equalTo(loginBtn.mas_top).offset(-kZoomValue(leftSpace));
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    
    [_mobileTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
        make.bottom.equalTo(_passwordTf.mas_top).offset(-kZoomValue(20));
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    
}
- (void)loginApp:(UIButton *)btn{
    
    
    if(_mobileTf.text.length==0){
        [Dialog simpleToast:@"The phone number can't be empty"];
        return;
    }
    BOOL isNumber = [NSString isMobileNumber:_mobileTf.text];
    if(_mobileTf.text.length<kMobileNumberMinLength||!isNumber){
        [Dialog simpleToast:@"Incorrect phone number"];
        return;
    }
    if(_passwordTf.text.length==0){
        [Dialog simpleToast:@"The password can't be empty"];
        return;
    }
    if(_passwordTf.text.length<6){
        [Dialog simpleToast:@"The password's length 6~14 "];
        return;
    }
    NSString *password = [NSString sha1:_passwordTf.text];
    NSDictionary *param = @{@"username": _mobileTf.text,
                            @"password": password};
    [HqHttpUtil hqPostShowHudTitle:nil param:param url:@"/users/sessions" complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"登录===%@",responseObject);
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                NSString *token = [responseObject hq_objectForKey:@"token"];
                SetUserDefault(token, kToken);
                SetUserDefault(@"1", kisLogin);
                
                AppDelegate *app = [AppDelegate shareApp];
                app.isInputGesturePassword = NO;
                [AppDelegate setRootVC:HqSetRootVCHome];
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
    
    
}
- (void)forgotPassword:(UIButton *)btn{
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if ([textField isEqual:_mobileTf]) {
        if (textField.text.length >=kMobileNumberLength) {
            return NO;
        }
    }
    
    if ([textField isEqual:_passwordTf]) {
        if (textField.text.length >=kPasswordMaxLength) {
            return NO;
        }
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
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

