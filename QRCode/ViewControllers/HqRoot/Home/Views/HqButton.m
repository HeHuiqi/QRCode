//
//  HqButton.m
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqButton.h"
@interface HqButton()

@property (nonatomic,strong) UIButton *icon;
@property (nonatomic,strong) UILabel *titleLab;

@end

@implementation HqButton

- (instancetype)init{
    if(self = [super init]){
        [self setup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}
- (void)setup{
    _isSetHighlighted = YES;
    _icon = [UIButton buttonWithType:UIButtonTypeSystem];
    _icon.tintColor = [UIColor whiteColor];
    _icon.contentMode = UIViewContentModeScaleAspectFit;
    _icon.userInteractionEnabled = NO;
    [self addSubview:_icon];
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.equalTo(self).offset(kZoomValue(10));
    }];
    
    _titleLab = [[UILabel alloc] init];
    _titleLab.textColor = [UIColor whiteColor];
    _titleLab.font = [UIFont boldSystemFontOfSize:kZoomValue(17)];
    [self addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-kZoomValue(10));
    }];
}
- (void)setIconSize:(CGSize)iconSize{
    _iconSize = iconSize;
    [_icon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(_iconSize);
    }];
}
- (void)setIconImage:(UIImage *)iconImage{
    _iconImage = iconImage;
    if (_iconImage) {
        [_icon setImage:_iconImage forState:UIControlStateNormal];
    }
}
- (void)setIsSetHighlighted:(BOOL)isSetHighlighted{
    _isSetHighlighted = isSetHighlighted;
}
- (void)setTitle:(NSString *)title{
    _title = title;
    if (_title) {
        _titleLab.text = title;
    }
}
- (void)setSelected:(BOOL)selected{
    if(selected){
        UIColor *corlor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        _titleLab.textColor = corlor;
        _icon.tintColor = corlor;
    }else{
        _titleLab.textColor = [UIColor whiteColor];
        _icon.tintColor = [UIColor whiteColor];
    }
}
- (void)setHighlighted:(BOOL)highlighted{
    if (!self.isSetHighlighted) {
        return;
    }
    if(highlighted){
       UIColor *corlor = COLOR(55, 69, 74, 1);
        _titleLab.textColor = corlor;
        _icon.tintColor = corlor;
    }else{
        _titleLab.textColor = [UIColor whiteColor];
        _icon.tintColor = [UIColor whiteColor];
    }
}

/*
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _titleLab.textColor = COLOR(55, 69, 74, 1);
    _icon.backgroundColor = COLOR(55, 69, 74, 1);
}
 */

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
