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
    _titleLab.textColor = HqGrayColor;
    [self addSubview:_titleLab];
    CGFloat leftSpace = 0;
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(leftSpace);
        make.top.equalTo(self).offset(0);
    }];
    _inputView = [[HqInputView alloc] initWithPlacehoder:@"Name"];
    _inputView.layer.borderWidth = 1.0;
    _inputView.layer.cornerRadius = kHqCornerRadius;
    _inputView.backgroundColor = [UIColor whiteColor];
    _inputView.layer.borderColor = HqBorderColor.CGColor;
    [self addSubview:_inputView];
    [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.mas_bottom).offset(kZoomValue(5));
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(-1.0);
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
