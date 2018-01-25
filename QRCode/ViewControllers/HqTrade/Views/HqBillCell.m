//
//  HqBillCell.m
//  QRCode
//
//  Created by macpro on 2018/1/19.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqBillCell.h"

@implementation HqBillCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    _leftIcon = [[UIImageView alloc] init];
    [self addSubview:_leftIcon];
    [_leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kZoomValue(15));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kZoomValue(51), kZoomValue(51)));
    }];
    _leftIcon.clipsToBounds = YES;
    _leftIcon.layer.cornerRadius = kZoomValue(51)/2.0;

    
    _merchantNameLab = [[UILabel alloc] init];
    _merchantNameLab.font = [UIFont systemFontOfSize:kZoomValue(16)];
    _merchantNameLab.textColor = COLORA(97, 97, 97);
    [self addSubview:_merchantNameLab];
    [_merchantNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftIcon.mas_right).offset(kZoomValue(14));
        make.bottom.equalTo(self.mas_centerY).offset(-kZoomValue(4));
        
    }];
    
    _payTimeLab = [[UILabel alloc] init];
    _payTimeLab.font = [UIFont systemFontOfSize:kZoomValue(15)];
    _payTimeLab.textColor = COLORA(196,198,203);
    [self addSubview:_payTimeLab];
    [_payTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftIcon.mas_right).offset(kZoomValue(14));
        make.top.equalTo(self.mas_centerY).offset(kZoomValue(4));
        
    }];
    
    _payamountLab = [[UILabel alloc] init];
    _payamountLab.font = [UIFont systemFontOfSize:kZoomValue(16)];
    _payamountLab.textColor = COLORA(97, 97, 97);
    [self addSubview:_payamountLab];
    [_payamountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kZoomValue(15));
        make.top.equalTo(_merchantNameLab.mas_top);
    }];
}
- (void)setBill:(HqBill *)bill{
    _bill = bill;
    if (_bill) {
        //temp
        _leftIcon.image = [UIImage imageNamed:@"bill_temp_icon"];
        
        _merchantNameLab.text = _bill.merchantName;
        HqDateFormatter *date = [HqDateFormatter shareInstance];
        NSString *dateStr = [date dateStringWithFormat:@"yyyy-MM-dd HH:mm:ss" timeInterval:_bill.payTime/1000.0];
        _payTimeLab.text = dateStr;
        NSString *count = [NSString stringWithFormat:@"-%0.2f₫",_bill.amount];
        if (_bill.status==0) {
           count = [NSString stringWithFormat:@"%0.2f₫",_bill.amount];
        }
        _payamountLab.text = count;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
