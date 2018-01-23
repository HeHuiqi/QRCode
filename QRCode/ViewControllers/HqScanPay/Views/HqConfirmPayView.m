//
//  HqComfirmPayView.m
//  QRCode
//
//  Created by macpro on 2018/1/23.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqConfirmPayView.h"

@interface HqConfirmPayView()<HqPassWordViewDelegate>

@property (nonatomic,strong) UIView *contentView;

@end

@implementation HqConfirmPayView
- (instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    
    self.backgroundColor = [COLOR(38, 38, 38, 1) colorWithAlphaComponent:0.9];
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SCREEN_HEIGHT-300-kZoomValue(350)/2.0);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.height.mas_equalTo(kZoomValue(300));
    }];
    self.contentView = contentView;

    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeBtn setImage:[UIImage imageNamed:@"pay_close_icon"] forState:UIControlStateNormal];
    [contentView addSubview:_closeBtn];
    _closeBtn.tag = 1;
    [_closeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(15));
        make.top.equalTo(contentView).offset(kZoomValue(15));
        make.size.mas_equalTo(CGSizeMake(kZoomValue(30), kZoomValue(30)));
    }];
    
    _titleLab = [[UILabel alloc] init];
    _titleLab.text = @"Please enter the payment password";
    _titleLab.font = [UIFont systemFontOfSize:kZoomValue(15)];
    [contentView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.centerY.equalTo(_closeBtn.mas_centerY);
    }];
    
    UIView *xline = [[UIView alloc] init];
    xline.backgroundColor = LineColor;
    [contentView addSubview:xline];
    [xline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(0));
        make.top.equalTo(_closeBtn.mas_bottom).offset(kZoomValue(2));
        make.right.equalTo(contentView).offset(0);
        make.height.mas_equalTo(LineHeight);
    }];
    
    _passwordView = [[HqPassWordView alloc] init];
    
    CGFloat passwprdHeight = (SCREEN_WIDTH - kZoomValue(40))/6.0;
    //    password.frame = CGRectMake(kZoomValue(20), CGRectGetMaxY(_infoLab.frame)+kZoomValue(20), passwprdHeight*6.0, passwprdHeight);
    _passwordView.passWordNum = 6;
    _passwordView.squareWidth = passwprdHeight;
    _passwordView.pointRadius = 6;
    _passwordView.pointColor = [UIColor blackColor];
    _passwordView.rectColor = HqBorderColor;
    [contentView addSubview:_passwordView];
    _passwordView.delegate = self;
    [_passwordView becomeFirstResponder];
    
    [_passwordView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(xline.mas_bottom).offset(kZoomValue(17));
        make.left.equalTo(contentView).offset(kZoomValue(20));
        make.right.equalTo(contentView).offset(-kZoomValue(20));
        make.height.mas_equalTo(passwprdHeight);
    }];
    
    NSString *title = @"Forgot password?";
    UIColor *titleColor = [UIColor darkTextColor];
    HqString *str = [[HqString alloc] initWithHqString:title];
    [str setHqUnderlineColor:titleColor lineStyle:NSUnderlineStyleSingle range:NSMakeRange(0, title.length)];
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    forgetBtn.tintColor = titleColor;
    [forgetBtn setAttributedTitle:str.hqAttributedString forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:forgetBtn];
    
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView).offset(-kZoomValue(20));
        make.top.equalTo(_passwordView.mas_bottom).offset(kZoomValue(10));
        make.height.mas_equalTo(kZoomValue(30));
    }];
    forgetBtn.tag = 2;
    self.forgetBtn = forgetBtn;
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void)btnClick:(UIButton *)btn{
    [self dismissPayView];
}

- (void)showPayView{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (keyWindow) {
        
        [keyWindow addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(keyWindow).offset(0);
            make.left.equalTo(keyWindow).offset(0);
            make.right.equalTo(keyWindow).offset(0);
            make.bottom.equalTo(keyWindow).offset(0);
        }];
        [_passwordView becomeFirstResponder];
        [_passwordView reInput];
    }
}
- (void)dismissPayView{
    
    if (self.superview) {
        [self removeFromSuperview];
    }
}
- (void)keyboardWillShow:(NSNotification *)notifi{
    //获取键盘的高度
    NSDictionary *userInfo = [notifi userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SCREEN_HEIGHT-height-kZoomValue(350)/2.0);
    }];
    
}
- (void)keyboardWillHide{
    [self dismissPayView];
}
#pragma mark - HqPassWordViewDelegate
- (void)passWordCompleteInput:(HqPassWordView *)passWord{
    if (self.delegate) {
        [self.delegate hqConfirmPayView:self password:passWord.textStore];
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

