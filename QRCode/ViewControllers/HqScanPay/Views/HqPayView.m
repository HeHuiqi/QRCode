//
//  HqPayView.m
//  QRCode
//
//  Created by macpro on 2018/1/22.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqPayView.h"

@implementation HqPayView

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}
- (void)setup{
    UILabel *accountInfoLab = [[UILabel alloc] init];
    accountInfoLab.font = [UIFont systemFontOfSize:15];
    accountInfoLab.text = @"Account";
    [self addSubview:accountInfoLab];
    [accountInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(kZoomValue(30));
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
