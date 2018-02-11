//
//  HqTransferInfoView.m
//  QRCode
//
//  Created by macpro on 2018/2/11.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqTransferInfoView.h"

@implementation HqTransferInfoView
- (instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    _leftIcon = [[UIImageView alloc] init];
    _leftIcon.backgroundColor = [UIColor redColor];
    [self addSubview:_leftIcon];
    [_leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kZoomValue(20), kZoomValue(20)));
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kZoomValue(15));
    }];
    
    _titleLab = [[UILabel alloc] init];
    _titleLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_leftIcon.mas_right).offset(kZoomValue(15));
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
