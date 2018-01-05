//
//  HqButton.m
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqButton.h"

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
    _icon = [[UIImageView alloc] init];
    _icon.contentMode = UIViewContentModeScaleAspectFit;
    _icon.backgroundColor = [UIColor whiteColor];
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

- (void)setHighlighted:(BOOL)highlighted{
    
    if(highlighted){
        _titleLab.textColor = COLOR(55, 69, 74, 1);
        _icon.backgroundColor = COLOR(55, 69, 74, 1);
    }else{
        _titleLab.textColor = [UIColor whiteColor];
        _icon.backgroundColor = [UIColor whiteColor];
    }
}

/*
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _titleLab.textColor = COLOR(55, 69, 74, 1);
    _icon.backgroundColor = COLOR(55, 69, 74, 1);
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _titleLab.textColor = [UIColor whiteColor];
    _icon.backgroundColor = [UIColor whiteColor];
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
