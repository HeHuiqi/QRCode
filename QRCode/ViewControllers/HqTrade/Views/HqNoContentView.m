//
//  HqNoContentView.m
//  QRCode
//
//  Created by macpro on 2018/1/19.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqNoContentView.h"

@implementation HqNoContentView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    _centerIcon =[[UIImageView alloc] init];
    [self addSubview:_centerIcon];
    CGFloat width = 118;
    [_centerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(-kZoomValue(width));
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(width, width));
    }];
    
    _infoLab = [[UILabel alloc] init];
    _infoLab.textColor = HqGrayColor;
    [self addSubview:_infoLab];
    [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_centerIcon.mas_bottom).offset(kZoomValue(20));
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
