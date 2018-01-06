//
//  HqIdInfoInputView.m
//  QRCode
//
//  Created by hehuiqi on 2018/1/6.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqIdInfoInputView.h"

@implementation HqIdInfoInputView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    _titleLab = [[UILabel alloc] init];
    _titleLab.font = [UIFont systemFontOfSize:kZoomValue(12)];
    [self addSubview:_titleLab];
    CGFloat leftSpace = 20;
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kZoomValue(leftSpace));
        make.top.equalTo(self).offset(0);
    }];
    _inputView = [[HqInputView alloc] initWithPlacehoder:@"Name"];
    _inputView.layer.borderWidth = 1.0;
    _inputView.layer.cornerRadius = 2.0;
    [self addSubview:_inputView];
    [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.mas_bottom).offset(kZoomValue(5));
        make.left.equalTo(self).offset(kZoomValue(leftSpace));
        make.right.equalTo(self).offset(-kZoomValue(leftSpace));
        make.height.mas_equalTo(kZoomValue(45));
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