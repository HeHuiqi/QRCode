//
//  HqTransferView.m
//  QRCode
//
//  Created by macpro on 2018/2/11.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqTransferView.h"
#import "HqTransferInfoView.h"

@interface HqTransferView()

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) HqTransferInfoView *transferInfoView;
@property (nonatomic,strong) HqPayCodeView *payCodeView;


@property (nonatomic,assign) BOOL isPaying;//是否正在支付

@end

@implementation HqTransferView

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
        make.top.equalTo(self).offset(kZoomValue(0));
        make.left.equalTo(self).offset(kZoomValue(15));
        make.right.equalTo(self).offset(kZoomValue(-15));
        make.height.mas_equalTo(kZoomValue(400));
    }]; 
    
    _transferInfoView = [[HqTransferInfoView alloc]init];
    _transferInfoView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _transferInfoView.leftIcon = nil;
    _transferInfoView.titleLab.text = _userName;
    [_contentView addSubview:_transferInfoView];
    [_transferInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView).offset(kZoomValue(0));
        make.left.equalTo(_contentView).offset(0);
        make.right.equalTo(_contentView).offset(0);
        make.height.mas_equalTo(kZoomValue(40));
    }];
    
    _payCodeView = [[HqPayCodeView alloc]init];
    _payCodeView.backgroundColor = [UIColor grayColor];
    _payCodeView.payCodeType = HqPayCodeTypeTransfer;
    _payCodeView.params = _params;
    [_contentView addSubview:_payCodeView];
    [_payCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_contentView);
        make.centerY.equalTo(_contentView);
        make.size.mas_equalTo(CGSizeMake(kZoomValue(240), kZoomValue(240)));
    }];
    
}
- (void)setUserName:(NSString *)userName{
    _transferInfoView.titleLab.text = userName;
}
- (void)setUserIconUrl:(NSString *)userIconUrl{
    [_transferInfoView.leftIcon sd_setImageWithURL:[NSURL URLWithString:userIconUrl] placeholderImage:nil];
}
- (void)setParams:(NSDictionary *)params{
    _payCodeView.params = params;
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
