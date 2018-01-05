//
//  SuperVC.m
//  HHQ
//
//  Created by iMac on 15/6/8.
//  Copyright (c) 2015年 HHQ. All rights reserved.
//

#import "SuperVC.h"
#define BarHeight 64
@interface SuperVC ()

@end

@implementation SuperVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navBarView];
    [self titelLab];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];;
    self.leftBtn.tintColor = COLOR(102, 102, 102, 1);

    self.leftBtnImageName = nil;
    
   
}
- (UILabel *)titelLab{
    if (!_titelLab) {
        _titelLab = [[UILabel alloc]init];
        _titelLab.font = [UIFont systemFontOfSize:18.0];
        [self.navBarView addSubview:_titelLab];
        [_titelLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.navBarView.mas_centerX);
            make.top.equalTo(_navBarView).offset(20);
            make.height.mas_equalTo(44);
        }];
    }
    return _titelLab;
}
- (void)setLeftBtn:(UIButton *)leftBtn{
    
    if (leftBtn) {
        [_leftBtn removeFromSuperview];
        _leftBtn = leftBtn;
        [self.navBarView addSubview:_leftBtn];
    }
    [_leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_navBarView).offset(0);
        make.top.equalTo(_navBarView).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 44));
    }];
}
- (void)setLeftBtnImageName:(NSString *)leftBtnImageName{

    UIImage * image = nil;
    if (leftBtnImageName.length > 0) {
        image = [UIImage imageNamed:leftBtnImageName];
    }else{
        image = [UIImage imageNamed:@"back"];
    }
    image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [_leftBtn setImage:image forState:UIControlStateNormal];
}

- (void)setRightBtn:(UIButton *)rightBtn{
    _rightBtn = rightBtn;
    
    if (rightBtn) {
        [_rightBtn removeFromSuperview];
        _rightBtn = rightBtn;
        [self.navBarView addSubview:_rightBtn];
    }
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_navBarView).offset(0);
        make.top.equalTo(_navBarView).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 44));
    }];
}
- (void)setRightBtnImageName:(NSString *)rightBtnImageName{
    
    UIImage * image = [UIImage imageNamed:rightBtnImageName];
    
    [_rightBtn setImage:image forState:UIControlStateNormal];
}
- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    _titelLab.text = title;
}
-(UIView *)navBarView{
    if (!_navBarView) {
        _navBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, BarHeight)];
        _navBarView.backgroundColor = [UIColor whiteColor];
    }
    
    return _navBarView;
}
- (void)setIsShowBottomLine:(BOOL)isShowBottomLine{
    _isShowBottomLine = isShowBottomLine;
    
    if (_isShowBottomLine) {
        UIView *xline = [[UIView alloc] init];
        xline.backgroundColor = COLOR(229, 229, 229, 1);
        [_navBarView addSubview:xline];
        [xline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_navBarView).offset(0);
            make.left.equalTo(self.view).offset(0);
            make.right.equalTo(self.view).offset(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
        }];
        _bottomLine = xline;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)backClick
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)shareData{
}
@end
