//
//  HqCardInfoView.m
//  QRCode
//
//  Created by macpro on 2018/1/25.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqCardInfoView.h"

@implementation HqCardInfoView

- (instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    
    _leftLab = [[UILabel alloc] init];
    _leftLab.textColor = COLOR(0,0,0,0.3);
    _leftLab.font =[UIFont systemFontOfSize:kZoomValue(10)];
    [self addSubview:_leftLab];
    
    [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kZoomValue(10));
        make.centerY.equalTo(self);
    }];
    
    _rightLab = [[UILabel alloc] init];
    _rightLab.textColor = [UIColor whiteColor];
    _rightLab.font =[UIFont systemFontOfSize:kZoomValue(14)];
    [self addSubview:_rightLab];
    [_rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(kZoomValue(-10));
        make.centerY.equalTo(self);
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
