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
@property (nonatomic,strong) UILabel *subCenterLab;
@property (nonatomic,strong) UILabel *moneyLab;




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
    _contentView.layer.cornerRadius = kHqCornerRadius;
    _contentView.clipsToBounds = YES;
    
    _transferInfoView = [[HqTransferInfoView alloc]init];
    _transferInfoView.backgroundColor = COLORA(250,250,250);
    _transferInfoView.titleLab.text = _title;
    _transferInfoView.titleLab.textColor = COLORA(195,195,195);

    [_contentView addSubview:_transferInfoView];
    [_transferInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView).offset(kZoomValue(0));
        make.left.equalTo(_contentView).offset(0);
        make.right.equalTo(_contentView).offset(0);
        make.height.mas_equalTo(kZoomValue(40));
    }];
    _subCenterLab = [[UILabel alloc] init];
    _subCenterLab.text = _subCenterTitle;
    [_contentView addSubview:_subCenterLab];
    [_subCenterLab mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(_transferInfoView.mas_bottom).offset(kZoomValue(37));
        make.centerX.equalTo(_contentView);
    }];
    
    _payCodeView = [[HqPayCodeView alloc]init];
    _payCodeView.backgroundColor = [UIColor grayColor];
    _payCodeView.payCodeType = HqPayCodeTypeTransfer;
    _payCodeView.params = _params;
    [_contentView addSubview:_payCodeView];
    [_payCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_contentView);
        make.centerY.equalTo(_contentView);
        make.size.mas_equalTo(CGSizeMake(kZoomValue(180), kZoomValue(180)));
    }];
    
    _moneyLab = [[UILabel alloc] init];
    _moneyLab.font = [UIFont systemFontOfSize:kZoomValue(30)];
    [_contentView addSubview:_moneyLab];
    _moneyLab.textColor = COLORA(72,90,101);
    [_moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_payCodeView.mas_bottom).offset(kZoomValue(12));
        make.centerX.equalTo(_contentView);
    }];
    
}
- (void)setUserName:(NSString *)userName{
}
- (void)setTitleIconName:(NSString *)titleIconName{
    _transferInfoView.leftIcon.image = [UIImage imageNamed:titleIconName];
}
- (void)setTitle:(NSString *)title{
    _transferInfoView.titleLab.text = title;
}
- (void)setSubCenterTitle:(NSString *)subCenterTitle{
    _subCenterLab.text = subCenterTitle;
}
- (void)setMoney:(CGFloat)money{
    _moneyLab.text = [NSString stringWithFormat:@"₫ %.2f",money];
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
