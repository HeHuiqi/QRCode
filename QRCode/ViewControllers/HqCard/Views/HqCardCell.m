//
//  HqCardCell.m
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqCardCell.h"

@implementation HqCardCell

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
    _bankNameLab = [[UILabel alloc] init];
    _bankNameLab.textColor = [UIColor whiteColor];
    _bankNameLab.font = [UIFont systemFontOfSize:kZoomValue(18)];
    [bgView addSubview:_bankNameLab];
    [_bankNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(kZoomValue(29));
        make.top.equalTo(bgView).offset(kZoomValue(20));
    }];
    
    
    _cardTypeLab = [[UILabel alloc] init];
    _cardTypeLab.textColor = [UIColor whiteColor];
    _cardTypeLab.font = [UIFont systemFontOfSize:kZoomValue(13)];
    [bgView addSubview:_cardTypeLab];
    [_cardTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(kZoomValue(29));
        make.top.equalTo(_bankNameLab.mas_bottom).offset(kZoomValue(5));
    }];
    
    _cardNumberLab = [[UILabel alloc] init];
    _cardNumberLab.textColor = [UIColor whiteColor];

        NSString *fontPath = [[NSBundle mainBundle] pathForResource:@"MSPMincho" ofType:@"ttf"];
    _cardNumberLab.font = [UIFont customFontWithPath:fontPath size:kZoomValue(24)];
    [bgView addSubview:_cardNumberLab];
    [_cardNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView).offset(kZoomValue(20));
        make.centerX.equalTo(bgView);
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
