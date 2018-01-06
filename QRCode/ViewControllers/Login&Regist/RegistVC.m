//
//  RegistVC.m
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "RegistVC.h"
#import "HqInputView.h"
#define Time 60
@interface RegistVC ()<UITextFieldDelegate>

@property (nonatomic,strong) HqInputView *mobileTf;
@property (nonatomic,strong) HqInputView *checkCodeTf;

@property (nonatomic,strong) UIButton *checkBtn;
@property (nonatomic,strong) NSTimer *checkCodeTimer;
@property (nonatomic,assign) int totalTime;



@end

@implementation RegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self initView];
    
    
}
- (void)iniData{
    _totalTime = Time;
}
- (void)getCheckCodeTimer{
    _totalTime--;
    UIColor *btnColor = HqDeepGrayColor;
    NSString *title = [NSString stringWithFormat:@"Send(%ds)",_totalTime];
    if (_totalTime == 0)
    {
        [self destroyTimer];
        title = @"Send";
        btnColor = AppMainColor;
        _checkBtn.userInteractionEnabled = YES;
    }
    [_checkBtn setTitleColor:btnColor forState:UIControlStateNormal];
    [_checkBtn setTitle:title forState:UIControlStateNormal];
}
- (void)destroyTimer
{
    [_checkCodeTimer invalidate];
    _checkCodeTimer = nil;
    _totalTime = Time;
    _checkBtn.userInteractionEnabled = YES;
    
}
- (void)initView{
    UIView *contentView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:contentView];
    
    CGFloat inputHeight = 45;
    CGFloat leftSpace = 20;
    _mobileTf = [[HqInputView alloc] initWithPlacehoder:@"Phone number" leftIcon:@""];
    _mobileTf.keyboardType = UIKeyboardTypeNumberPad;
    [contentView addSubview:_mobileTf];
    
    _checkCodeTf = [[HqInputView alloc] initWithPlacehoder:@"Verfication code" leftIcon:@""];
    _checkCodeTf.keyboardType = UIKeyboardTypeNumberPad;
    [contentView addSubview:_checkCodeTf];
    
    
    NSString *title = @"Send";
    UIColor *titleColor = [UIColor darkTextColor];
    UIButton *checkCodeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    checkCodeBtn.tintColor = titleColor;
    checkCodeBtn.tintColor = AppMainColor;
    checkCodeBtn.backgroundColor = [UIColor whiteColor];
    [checkCodeBtn setTitle:title forState:UIControlStateNormal];
    [checkCodeBtn addTarget:self action:@selector(geCheckCode:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:checkCodeBtn];
    
    self.checkBtn = checkCodeBtn;
    
    
    [_mobileTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
        make.top.equalTo(contentView.mas_centerY).offset(kZoomValue(20));
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    
    [checkCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mobileTf.mas_bottom).offset(kZoomValue(20));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
        make.size.mas_equalTo(CGSizeMake(kZoomValue(80), kZoomValue(inputHeight)));
    }];
    
    [_checkCodeTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.right.equalTo(checkCodeBtn.mas_left).offset(-kZoomValue(10));
        make.top.equalTo(_mobileTf.mas_bottom).offset(kZoomValue(20));
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    registBtn.tintColor = [UIColor whiteColor];
    [registBtn setTitle:@"Sign Up" forState:UIControlStateNormal];
    registBtn.backgroundColor = COLOR(17, 139, 226, 1);
    [registBtn addTarget:self action:@selector(signApp:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:registBtn];
    
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.top.equalTo(_checkCodeTf.mas_bottom).offset(kZoomValue(leftSpace));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    
  
    
}
- (void)signApp:(UIButton *)btn{
    
    if(_mobileTf.text.length==0){
        [Dialog simpleToast:@"The phone number can't be empty"];
        return;
    }
    if(_mobileTf.text.length<kPasswordMaxLength){
        [Dialog simpleToast:@"Incorrect phone number"];
        return;
    }
    if(_checkCodeTf.text.length==0){
        [Dialog simpleToast:@"The verfication code can't be empty"];
        return;
    }
    if(_checkCodeTf.text.length<6){
        [Dialog simpleToast:@"The verfication code length 6 "];
        return;
    }
    [HqAFHttpClient starRequestWithHeaders:nil withURLString:@"" withParam:@{} requestIsNeedJson:YES responseIsNeedJson:YES requestMethod:Post requestCompleBlock:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        
    }];
    //    [AppDelegate setRootVC:HqSetRootVCHome];
    
}
- (void)geCheckCode:(UIButton *)btn{
    
    /*
    if(_mobileTf.text.length==0){
        [Dialog simpleToast:@"The phone number can't be empty"];
        return;
    }
    if(_mobileTf.text.length<kPasswordMaxLength){
        [Dialog simpleToast:@"Incorrect phone number"];
        return;
    }*/
    
    [self destroyTimer];
    if (_checkCodeTimer == nil)
    {
        btn.userInteractionEnabled = NO;
        _checkCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getCheckCodeTimer) userInfo:nil repeats:YES];
    }
    /*
    NSString *url = [NSString stringWithFormat:@"/users/codes/%@",_mobileTf.text];
    [HqAFHttpClient starRequestWithHeaders:nil withURLString:url withParam:nil requestIsNeedJson:YES responseIsNeedJson:YES requestMethod:Get requestCompleBlock:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"获取验证码 = =%@",responseObject)

        if (response.statusCode == 200) {
            
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int status = [[responseObject hq_objectForKey:@"status"] intValue];
            if (status == 0) {
                
                [Dialog simpleToast:@"Verfication code sended"];
            }else{
                [self destroyTimer];
                [Dialog simpleToast:msg];
            }
            
        }else{
            [self destroyTimer];
            [Dialog simpleToast:@""];
        }
    }];
     */
    
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
    
    if ([textField isEqual:_checkCodeTf]) {
        if (textField.text.length >=6) {
            return NO;
        }
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
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
