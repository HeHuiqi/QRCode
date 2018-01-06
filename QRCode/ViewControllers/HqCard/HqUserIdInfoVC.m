//
//  HqUserIdInfoVC.m
//  QRCode
//
//  Created by hehuiqi on 2018/1/6.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqUserIdInfoVC.h"
#import "HqIdInfoInputView.h"
#import "HqAddCardVC.h"


@interface HqUserIdInfoVC ()<UITextFieldDelegate>

@property (nonatomic,strong) HqIdInfoInputView *nameInputView;
@property (nonatomic,strong) HqIdInfoInputView *certTypeView;
@property (nonatomic,strong) HqIdInfoInputView *idInputView;


@end

@implementation HqUserIdInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"User identify";
    [self initView];
}
- (void)initView{
    
    UIView *contentView = self.view;
    
    UILabel *infoLab = [[UILabel alloc] initWithFrame:CGRectMake(kZoomValue(20), CGRectGetMaxY(self.navBarView.frame)+40, SCREEN_WIDTH-60, 13)];
    infoLab.font = [UIFont systemFontOfSize:kZoomValue(12)];
    infoLab.text = @"Please fill in the bank reserver infomation";
    [contentView addSubview:infoLab];
    CGFloat cellHeight = kZoomValue(65);
    CGFloat ySpace = 20;
    
    _nameInputView = [[HqIdInfoInputView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(infoLab.frame)+kZoomValue(ySpace), SCREEN_WIDTH, cellHeight)];
    _nameInputView.titleLab.text = @"Name";
    [contentView addSubview:_nameInputView];
    
    
    
    UIButton *certChooseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    certChooseBtn.frame =  CGRectMake(0, 0, 40, kZoomValue(45));
    certChooseBtn.tintColor = [UIColor whiteColor];
    [certChooseBtn setTitle:@"cho" forState:UIControlStateNormal];
    certChooseBtn.backgroundColor = COLOR(17, 139, 226, 1);
    [certChooseBtn addTarget:self action:@selector(chooseCert:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:certChooseBtn];
    
    _certTypeView = [[HqIdInfoInputView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameInputView.frame)+kZoomValue(ySpace), SCREEN_WIDTH, cellHeight)];
    _certTypeView.titleLab.text = @"Certificate Type";
    _certTypeView.inputView.placeholder = @"ID Card No.";
    _certTypeView.inputView.delegate = self;
    _certTypeView.inputView.rightViewMode = UITextFieldViewModeAlways;
    _certTypeView.inputView.rightView = certChooseBtn;
    [contentView addSubview:_certTypeView];
    
    _idInputView = [[HqIdInfoInputView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_certTypeView.frame)+kZoomValue(ySpace), SCREEN_WIDTH, cellHeight)];
    _idInputView.titleLab.text = @"ID Number";
    _idInputView.inputView.placeholder = @"ID Number";
    _idInputView.inputView.delegate = self;
    [contentView addSubview:_idInputView];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    nextBtn.tintColor = [UIColor whiteColor];
    [nextBtn setTitle:@"Next" forState:UIControlStateNormal];
    nextBtn.backgroundColor = COLOR(17, 139, 226, 1);
    nextBtn.layer.cornerRadius = 2.0;
    [nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:nextBtn];
    
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(ySpace));
        make.top.equalTo(_idInputView.mas_bottom).offset(kZoomValue(ySpace));
        make.right.equalTo(contentView).offset(-kZoomValue(ySpace));
        make.height.mas_equalTo(kZoomValue(kZoomValue(45)));
    }];
    
}
- (void)chooseCert:(UIButton *)btn{
    NSLog(@"sgsd");
}
- (void)nextClick:(UIButton *)btn{
    
    HqAddCardVC *addCardVC = [[HqAddCardVC alloc] init];
    Push(addCardVC);
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:_certTypeView.inputView]) {
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
