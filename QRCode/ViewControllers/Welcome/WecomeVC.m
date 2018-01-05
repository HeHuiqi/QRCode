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
    logoImageView.backgroundColor = [UIColor redColor];
    
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(kZoomValue(150));
        make.centerX.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(kZoomValue(150), kZoomValue(200)));
    }];
    
    UILabel *infoLab = [[UILabel alloc] init];
    infoLab.text = @"125215151\ndgjhadshjgsd dshgjds ";
    infoLab.numberOfLines = 0;
    infoLab.textColor = HqGrayColor;
    infoLab.textAlignment = NSTextAlignmentCenter;
    infoLab.font = [UIFont systemFontOfSize:kZoomValue(14)];
    [contentView addSubview:infoLab];
    [infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageView.mas_bottom).offset(kZoomValue(80));
        make.centerX.equalTo(contentView);
    }];
    
    
    
    CGFloat inputHeight = 45;
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    registBtn.tintColor = AppMainColor;
    [registBtn setTitle:@"Sign Up" forState:UIControlStateNormal];
    registBtn.backgroundColor = [UIColor whiteColor];
    [registBtn addTarget:self action:@selector(userOperate:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:registBtn];
    registBtn.layer.borderWidth = 1.0;
    registBtn.layer.borderColor = AppMainColor.CGColor;
    registBtn.layer.cornerRadius = 2.0;
    registBtn.tag = 1;
    
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(30));
        make.top.equalTo(infoLab.mas_bottom).offset(kZoomValue(40));
        make.right.equalTo(contentView.mas_centerX).offset(-kZoomValue(15));
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.tintColor = [UIColor whiteColor];
    [loginBtn setTitle:@"Log In" forState:UIControlStateNormal];
    loginBtn.backgroundColor = COLOR(17, 139, 226, 1);
    [loginBtn addTarget:self action:@selector(userOperate:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:loginBtn];
    loginBtn.layer.cornerRadius = 2.0;

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
