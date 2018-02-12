//
//  WecomeVC.m
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "WecomeVC.h"
#import "LoginVC.h"
#import "RegistVC.h"
@interface WecomeVC ()

@end

@implementation WecomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
- (void)initView{
    
    UIView *contentView = self.view;
    
    UIImageView *logoImageView = [[UIImageView alloc] init];
    [contentView addSubview:logoImageView];
    logoImageView.image = [UIImage imageNamed:@"welcom_icon"];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(kZoomValue(150));
        make.centerX.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(kZoomValue(254), kZoomValue(234)));
    }];
    
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.text = @"QRcode";
    nameLab.numberOfLines = 0;
    nameLab.textColor = COLORA(83,187,255);
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.font = [UIFont systemFontOfSize:kZoomValue(36)];
    [contentView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageView.mas_bottom).offset(kZoomValue(23));
        make.centerX.equalTo(contentView);
    }];
    UILabel *infoLab = [[UILabel alloc] init];
    infoLab.text = @"Laughing again, he brought the \n mirror away from Stephen's peering eyes.";
    infoLab.numberOfLines = 0;
    infoLab.textColor = COLORA(119,119,119);
    infoLab.textAlignment = NSTextAlignmentCenter;
    infoLab.font = [UIFont systemFontOfSize:kZoomValue(14)];
    [contentView addSubview:infoLab];
    [infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLab.mas_bottom).offset(kZoomValue(43));
        make.centerX.equalTo(contentView);
    }];
    
    
    
    CGFloat inputHeight = 45;
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [registBtn setTitle:@"Sign Up" forState:UIControlStateNormal];
    [registBtn setTitleColor:AppMainColor forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"btn_border"] forState:UIControlStateNormal];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateHighlighted];
    
    [registBtn addTarget:self action:@selector(userOperate:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:registBtn];
//    registBtn.layer.borderWidth = 1.0;
//    registBtn.layer.borderColor = AppMainColor.CGColor;
//    registBtn.layer.cornerRadius = 2.0;
    registBtn.tag = 1;
    
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(30));
        make.top.equalTo(infoLab.mas_bottom).offset(kZoomValue(40));
        make.right.equalTo(contentView.mas_centerX).offset(-kZoomValue(15));
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"btn_border"] forState:UIControlStateHighlighted];
    [loginBtn setTitle:@"Log In" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitleColor:AppMainColor forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(userOperate:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:loginBtn];

    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoLab.mas_bottom).offset(kZoomValue(40));
        make.left.equalTo(contentView.mas_centerX).offset(kZoomValue(15));
        make.right.equalTo(contentView).offset(-kZoomValue(30));
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
}
- (void)userOperate:(UIButton *)btn{
    
    if(btn.tag == 1){
        RegistVC *regist = [[RegistVC alloc] init];
        Push(regist);
    }else{
        
        LoginVC *login = [[LoginVC alloc] init];
        Push(login);
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
