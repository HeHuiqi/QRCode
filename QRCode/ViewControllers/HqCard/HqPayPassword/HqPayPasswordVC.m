//
//  HqPayPasswordVC.m
//  QRCode
//
//  Created by hehuiqi on 2018/1/6.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqPayPasswordVC.h"
#import "HqPassWordView.h"
#import "HqAddCardVC.h"

@interface HqPayPasswordVC ()

@property (nonatomic,strong) UILabel *infoLab;
@property (nonatomic,strong) HqPassWordView *passwordView;

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
    
    CGFloat space = 20;

    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    nextBtn.tintColor = [UIColor whiteColor];
    [nextBtn setTitle:@"Next" forState:UIControlStateNormal];
    nextBtn.backgroundColor = COLOR(17, 139, 226, 1);
    nextBtn.layer.cornerRadius = 2.0;
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
    HqAddCardVC *addCardVC = [[HqAddCardVC alloc] init];
    addCardVC.user = _user;
    Push(addCardVC);
}
- (void)backClick{
    [self backToVC:@"HqCardsVC"];
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
