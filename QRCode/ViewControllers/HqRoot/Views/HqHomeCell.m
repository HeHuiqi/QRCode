//
//  HqHomeCell.m
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqHomeCell.h"

@implementation HqHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    _titleLab = [[UILabel alloc] init];
    _titleLab.textColor = [UIColor blueColor];
    _titleLab.font = [UIFont systemFontOfSize:kZoomValue(16)];
    [self.contentView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kZoomValue(15));
        make.top.equalTo(self.contentView).offset(kZoomValue(30));
    }];
    
    
    _dateLab = [[UILabel alloc] init];
    _dateLab.textColor = HqGrayColor;
    _dateLab.font = [UIFont systemFontOfSize:kZoomValue(13)];
    [self.contentView addSubview:_dateLab];
    [_dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-kZoomValue(15));
        make.bottom.equalTo(_titleLab.mas_bottom);
    }];
    
    _dateIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_dateIcon];
    _dateIcon.backgroundColor = [UIColor redColor];
    [_dateIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_dateLab.mas_left).offset(-kZoomValue(10));
        make.top.equalTo(self.contentView).offset(kZoomValue(30));
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _contentLab = [[UILabel alloc] init];
    _contentLab.textColor = HqDeepGrayColor;
    _contentLab.font = [UIFont systemFontOfSize:kZoomValue(14)];
    [self.contentView addSubview:_contentLab];
    _contentLab.numberOfLines = 0;
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kZoomValue(15));
        make.right.equalTo(self.contentView).offset(-kZoomValue(15));
        make.top.equalTo(_titleLab.mas_bottom).offset(kZoomValue(30));
    }];
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
