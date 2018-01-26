//
//  HqCardDetailCell.m
//  QRCode
//
//  Created by macpro on 2018/1/18.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqCardDetailCell.h"

@implementation HqCardDetailCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = AppMainColor;
    bgView.layer.cornerRadius = kHqCornerRadius;
    [self.contentView addSubview:bgView];
    CGFloat leftSpace = kZoomValue(15);
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView ).offset(leftSpace);
        make.right.equalTo(self.contentView ).offset(-leftSpace);
        make.top.equalTo(self.contentView).offset(leftSpace);
        make.bottom.equalTo(self.contentView ).offset(-leftSpace);
    }];
    
    
    CGFloat innerSpace = kZoomValue(20);
    _bankIcon = [[UIImageView alloc] init];
    [bgView addSubview:_bankIcon];
    CGFloat iconWidth = kZoomValue(30);
    _bankIcon.layer.cornerRadius = iconWidth/2.0;
    _bankIcon.backgroundColor = [UIColor whiteColor];
    [_bankIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(innerSpace);
        make.top.equalTo(bgView).offset(innerSpace);
        make.size.mas_equalTo(CGSizeMake(iconWidth, iconWidth));
    }];
    
    _bankNameLab = [[UILabel alloc] init];
    _bankNameLab.textColor = [UIColor whiteColor];
    _bankNameLab.font = [UIFont systemFontOfSize:kZoomValue(18)];
    [bgView addSubview:_bankNameLab];
    [_bankNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bankIcon.mas_right).offset(kZoomValue(12));
        make.centerY.equalTo(_bankIcon.mas_centerY);
    }];
    _cardNumberLab = [[UILabel alloc] init];
    _cardNumberLab.textColor = [UIColor whiteColor];
    
    NSString *fontPath = [[NSBundle mainBundle] pathForResource:@"MSPMincho" ofType:@"ttf"];
    _cardNumberLab.font = [UIFont customFontWithPath:fontPath size:kZoomValue(24)];
    [bgView addSubview:_cardNumberLab];
    [_cardNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView.mas_centerY);
        make.centerX.equalTo(bgView);
    }];
    
    _cvvView = [[HqCardInfoView alloc] init];
    _cvvView.backgroundColor = COLORA(100,181,246);
    [bgView addSubview:_cvvView];
    [_cvvView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cardNumberLab.mas_bottom).offset(kZoomValue(20));
        make.right.equalTo(bgView).offset(-innerSpace);
        make.size.mas_equalTo(CGSizeMake(kZoomValue(90), kZoomValue(30)));
    }];
    
    
    _dateView = [[HqCardInfoView alloc] init];
    _dateView.backgroundColor = COLORA(100,181,246);
    [bgView addSubview:_dateView];
    [_dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cardNumberLab.mas_bottom).offset(kZoomValue(20));
        make.left.equalTo(bgView).offset(innerSpace);
        make.right.equalTo(_cvvView.mas_left).offset(-kZoomValue(20));
        make.height.mas_equalTo(kZoomValue(30));
    }];
    
  
    
}
- (void)setBankCard:(HqBankCard *)bankCard{
    _bankCard = bankCard;
    if (_bankCard) {
        _bankNameLab.text = _bankCard.bankName;
        if (_bankCard.type == 0 ) {
            _cardTypeLab.text = @"Debit Card";
        }else if(_bankCard.type == 1){
            _cardTypeLab.text = @"Credit Card";
        }else{
            _cardTypeLab.text = @"Other";
        }
        NSString *exp = _bankCard.exp;
        if (exp.length==0) {
            exp = @"--";
        }else{
            NSString *month = [_bankCard.exp substringWithRange:NSMakeRange(0, 2)];
            NSString *year = [_bankCard.exp substringWithRange:NSMakeRange(2, 2)];
            exp = [NSString stringWithFormat:@"%@/%@",month,year];
        }
        _dateView.leftLab.text = @"VALID THRU";
        _dateView.rightLab.text = exp;
        _cvvView.leftLab.text = @"CVV";
        if (_bankCard.cvv.length==0) {
            _bankCard.cvv = @"--";
        }
        _cvvView.rightLab.text = _bankCard.cvv;
        
        _cardNumberLab.text = [self formatterCardNum:_bankCard.cardNumber];
    }
}
- (NSString *)formatterCardNum:(NSString *)cardNum{
    if (!cardNum) {
        return @"";
    }
    NSString *lastFour = [cardNum substringWithRange:NSMakeRange(cardNum.length-4, 4)];
    cardNum = [NSString stringWithFormat:@"**** **** **** %@",lastFour];
    return cardNum;
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
