//
//  HqLeftViewCell.m
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqLeftViewCell.h"

@implementation HqLeftViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    _leftIcon = [UIButton buttonWithType:UIButtonTypeSystem];
    _leftIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_leftIcon];
    [_leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kZoomValue(36));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(kZoomValue(32), kZoomValue(32)));
    }];
    
    _titleLab = [[UILabel alloc] init];
    _titleLab.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftIcon.mas_right).offset(kZoomValue(29));
        make.centerY.equalTo(self.contentView);
    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        _leftIcon.tintColor = [UIColor whiteColor];
        _titleLab.textColor = [UIColor whiteColor];
    }else{
        _leftIcon.tintColor = COLOR(0, 159, 232, 1);
        _titleLab.textColor = [UIColor blackColor];
    }
}

@end
