//
//  HqScanResultVC.m
//  QRCode
//
//  Created by macpro on 2018/1/26.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqScanResultVC.h"
@interface HqScanResultVC ()

@end

@implementation HqScanResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Scan Result";
    UILabel *infoLab = [[UILabel alloc] init];
    [self.view addSubview:infoLab];
    [infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kZoomValue(20));
        make.right.equalTo(self.view).offset(-kZoomValue(20));
        make.centerY.equalTo(self.view);
    }];
    infoLab.text = _result;
    infoLab.numberOfLines = 0;
    
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
