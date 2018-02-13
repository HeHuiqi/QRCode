//
//  HqScanTransferResultVC.m
//  QRCode
//
//  Created by hehuiqi on 2018/2/12.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqScanTransferResultVC.h"

@interface HqScanTransferResultVC ()

@end

@implementation HqScanTransferResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
- (void)initView{
    self.title = @"Transfer the results";
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
        make.height.mas_equalTo(kZoomValue(230));
    }];
    
    UIImageView *statusIcon = [[UIImageView alloc] init];
    [contentView addSubview:statusIcon];
    [statusIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(contentView).offset(kZoomValue(28));
        make.size.mas_equalTo(CGSizeMake(kZoomValue(46), kZoomValue(46)));
    }];
    
    UILabel *infoLab = [[UILabel alloc] init];
    infoLab.textColor  = COLORA(72,90,101);
    infoLab.text = @"Pay for failure";
    [contentView addSubview:infoLab];
    [infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(statusIcon.mas_bottom).offset(kZoomValue(20));
    }];
    UILabel *moneyLab = [[UILabel alloc] init];
    moneyLab.textColor  = COLORA(72,90,101);
    moneyLab.font =[UIFont systemFontOfSize:kZoomValue(30)];
    moneyLab.text = [NSString stringWithFormat:@"₫ %.2f",_transfer.amount];
    [contentView addSubview:moneyLab];
    [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(infoLab.mas_bottom).offset(kZoomValue(17));
    }];
    
    UIView *xline = [[UIView alloc] init];
    xline.backgroundColor = COLORA(230,230,230 );
    [contentView addSubview:xline];
    [xline mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(contentView.mas_bottom).offset(kZoomValue(-45));
        make.left.equalTo(contentView).offset(kZoomValue(13));
        make.right.equalTo(contentView).offset(kZoomValue(-13));
        make.height.mas_equalTo(LineHeight);
    }];
    
    UILabel *leftNameLab = [[UILabel alloc] init];
    leftNameLab.textColor  = COLORA(72,90,101);
    leftNameLab.text = _transfer.payer;
    leftNameLab.font = [UIFont systemFontOfSize:kZoomValue(15)];
    [contentView addSubview:leftNameLab];
    [leftNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(xline.mas_bottom).offset(kZoomValue(15));
        make.left.equalTo(contentView).offset(kZoomValue(13));

    }];
    
    UILabel *rightNameLab = [[UILabel alloc] init];
    rightNameLab.textColor  = COLORA(72,90,101);
    rightNameLab.text = _transfer.payee;
    rightNameLab.font = [UIFont systemFontOfSize:kZoomValue(15)];
    [contentView addSubview:rightNameLab];
    [rightNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(xline.mas_bottom).offset(kZoomValue(15));
        make.right.equalTo(contentView).offset(kZoomValue(-13));
    }];
    
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    finishBtn.tintColor = [UIColor whiteColor];
    [finishBtn setTitle:@"Finish" forState:UIControlStateNormal];
    finishBtn.backgroundColor = COLOR(17, 139, 226, 1);
    [finishBtn addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    finishBtn.layer.cornerRadius = kHqCornerRadius;
    [self.view addSubview:finishBtn];
    
    [finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kZoomValue(leftSpace));
        make.top.equalTo(contentView.mas_bottom).offset(kZoomValue(15));
        make.right.equalTo(self.view).offset(-kZoomValue(leftSpace));
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    NSString *statusImage = nil;
    NSString *info = nil;

    if (_transferStatus == 1) {
        statusImage = @"success_icon";
        if (_transfer.type == 1) {
            info = @"Collect for success";
        }
        if (_transfer.type  == 2) {
            info = @"Pay for success";
        }
       
        
    }else{
        statusImage = @"fail_icon";
        if (_transfer.type  == 1) {
            info = @"Collect for fail";
        }
        if (_transfer.type  == 2) {
            info = @"Pay for fail";
        }
        [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kZoomValue(183));
        }];
        rightNameLab.hidden = YES;
        leftNameLab.hidden  = YES;
        xline.hidden = YES;
    }
    
    infoLab.text = info;
    
    statusIcon.image = [UIImage imageNamed:statusImage];

}
- (void)finish:(UIButton *)btn{
    BackRoot();
}
- (void)backClick{
    BackRoot();
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
