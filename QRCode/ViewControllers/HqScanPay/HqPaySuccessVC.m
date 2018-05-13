//
//  HqPaySuccessVC.m
//  QRCode
//
//  Created by macpro on 2018/1/23.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqPaySuccessVC.h"

@interface HqPaySuccessVC ()

@end

@implementation HqPaySuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
- (void)initView{
    self.title = @"Transfer Result";
    
    UIImageView *logo = [[UIImageView alloc] init];
    logo.image = [UIImage imageNamed:@"login_logo"];
    [self.view addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).offset(kZoomValue( self.navBarheight+48));
        make.size.mas_equalTo(CGSizeMake(kZoomValue(75), kZoomValue(75)));
    }];
    UILabel *infoLab = [[UILabel alloc] init];
    infoLab.text = @"Pay Success !";
    [self.view addSubview:infoLab];
    [infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(logo.mas_bottom).offset(kZoomValue(16));
    }];
    
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    finishBtn.tintColor = [UIColor whiteColor];
    [finishBtn setTitle:@"Finish" forState:UIControlStateNormal];
    finishBtn.backgroundColor = COLOR(17, 139, 226, 1);
    [finishBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishBtn];
    
    [finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kZoomValue(20));
        make.top.equalTo(infoLab.mas_bottom).offset(kZoomValue(46));
        make.right.equalTo(self.view).offset(-kZoomValue(20));
        make.height.mas_equalTo(kZoomValue(45));
    }];
    [AppDelegate shareApp].isPayer = YES;
}
- (void)finish{
    [self backToVC:@"HqRootVC"];

}
- (void)backClick{
     [self backToVC:@"HqRootVC"];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [AppDelegate shareApp].isPayer = NO;

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
