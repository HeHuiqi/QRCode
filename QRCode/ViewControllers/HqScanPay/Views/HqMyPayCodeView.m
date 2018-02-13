//
//  HqMyPayCodeView.m
//  QRCode
//
//  Created by macpro on 2018/1/19.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqMyPayCodeView.h"
@interface HqMyPayCodeView()

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) UILabel *titelLab;
@property (nonatomic,strong) UILabel *infoLab;
@property (nonatomic,strong) HqPayCodeView *payCodeView;


@property (nonatomic,assign) BOOL isPaying;//是否正在支付


@end

@implementation HqMyPayCodeView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _isPaying = YES;
        [self setup];
    }
    return self;
}
- (instancetype)init{
    if (self = [super init]) {
        _isPaying = YES;
        [self setup];
    }
    return self;
}
- (void)stopGetPayCode{
    [_payCodeView stopGetPayCode];
}
- (void)setup{
    
    _contentView = [[UIView alloc]init];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kZoomValue(290), kZoomValue(290)));
    }];
    _payCodeView = [[HqPayCodeView alloc]init];
    _payCodeView.backgroundColor = [UIColor grayColor];
    _payCodeView.payCodeType = HqPayCodeTypeMyself;
    [_contentView addSubview:_payCodeView];
    [_payCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_contentView);
        make.centerY.equalTo(_contentView);
        make.size.mas_equalTo(CGSizeMake(kZoomValue(240), kZoomValue(240)));
    }];
    _infoLab = [[UILabel alloc]init];
    _infoLab.text = @"If payment fails,\n other paymentmethods will be attempted ";
    _infoLab.font = [UIFont systemFontOfSize:kZoomValue(15)];
    _infoLab.numberOfLines = 0;
    _infoLab.textAlignment = NSTextAlignmentCenter;
    [_contentView addSubview:_infoLab];
    _infoLab.textColor = [UIColor whiteColor];
    [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_contentView);
        make.top.equalTo(_contentView.mas_bottom).offset(kZoomValue(32));
    }];
    
}
- (void)startGetPayCode{
    [_payCodeView startGetPayCode];
}
- (void)queryPayStatusWithCode:(NSString *)code{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
