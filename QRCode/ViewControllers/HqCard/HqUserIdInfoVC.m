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
    infoLab.textColor = HqGrayColor;
    [contentView addSubview:infoLab];
    CGFloat cellHeight = kZoomValue(65);
    CGFloat ySpace = 20;
    
    CGFloat xInput = kZoomValue(ySpace);
    CGFloat width = SCREEN_WIDTH  - 2*xInput;
    
    _nameInputView = [[HqIdInfoInputView alloc] initWithFrame:CGRectMake(xInput, CGRectGetMaxY(infoLab.frame)+kZoomValue(ySpace), width, cellHeight)];
    _nameInputView.titleLab.text = @"Name";
    [contentView addSubview:_nameInputView];
    
    
    
    UIButton *certChooseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    certChooseBtn.frame =  CGRectMake(0, 0, 40, kZoomValue(45));
    certChooseBtn.tintColor = COLORA(159,162,164);
    [certChooseBtn setImage:[UIImage imageNamed:@"down_arrow_icon"] forState:UIControlStateNormal];
    [certChooseBtn addTarget:self action:@selector(chooseCert:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:certChooseBtn];
    
    _certTypeView = [[HqIdInfoInputView alloc] initWithFrame:CGRectMake(xInput, CGRectGetMaxY(_nameInputView.frame)+kZoomValue(ySpace), width, cellHeight)];
    _certTypeView.titleLab.text = @"Certificate Type";
    _certTypeView.inputView.placeholder = @"ID Card No.";
    _certTypeView.inputView.delegate = self;
    _certTypeView.inputView.rightViewMode = UITextFieldViewModeAlways;
    _certTypeView.inputView.rightView = certChooseBtn;
    [contentView addSubview:_certTypeView];
    
    _idInputView = [[HqIdInfoInputView alloc] initWithFrame:CGRectMake(xInput, CGRectGetMaxY(_certTypeView.frame)+kZoomValue(ySpace), width, cellHeight)];
    _idInputView.titleLab.text = @"ID Number";
    _idInputView.inputView.placeholder = @"ID Number";
    _idInputView.inputView.delegate = self;
    [contentView addSubview:_idInputView];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    nextBtn.tintColor = [UIColor whiteColor];
    [nextBtn setTitle:@"Next" forState:UIControlStateNormal];
    nextBtn.backgroundColor = COLOR(17, 139, 226, 1);
    nextBtn.layer.cornerRadius = kHqCornerRadius;
    [nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:nextBtn];
    
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(xInput);
        make.top.equalTo(_idInputView.mas_bottom).offset(xInput);
        make.right.equalTo(contentView).offset(-xInput);
        make.height.mas_equalTo(kZoomValue(45));
    }];
    
}
- (void)chooseCert:(UIButton *)btn{
    NSLog(@"sgsd");
}
- (void)nextClick:(UIButton *)btn{
    
    [self updateUserInfo];
}
- (void)updateUserInfo{
    
    if (_nameInputView.inputView.text.length==0) {
        [Dialog simpleToast:@"The name can't be empty!"];
        return;
    }
    if (_idInputView.inputView.text.length==0) {
        [Dialog simpleToast:@"The idNumber can't be empty!"];
        return;
    }
    if (_idInputView.inputView.text.length<18) {
        [Dialog simpleToast:@"The idNumber invalidate"];
        return;
    }
    
    NSDictionary *param = @{ @"realName": _nameInputView.inputView.text,
                             @"idType": @"01",
                             @"idNumber": _idInputView.inputView.text};
    [HqHttpUtil hqPostShowHudTitle:nil param:param url:@"/users/identities" complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        if (response.statusCode == 200) {
            NSLog(@"上传个人证件信息==%@",responseObject)
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                HqUser *user = [[HqUser alloc] init];
                user.idNumber = _idInputView.inputView.text;
                user.realName = _nameInputView.inputView.text;
                HqAddCardVC *addCardVC = [[HqAddCardVC alloc] init];
                addCardVC.user = user;
                Push(addCardVC);
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:_certTypeView.inputView]) {
        return NO;
    }
    return YES;
}
- (void)backClick{
    [self backToVC:@"HqCardsVC"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
