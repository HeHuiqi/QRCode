//
//  HqAddCardInfoVC.m
//  QRCode
//
//  Created by hehuiqi on 2018/1/6.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqAddCardInfoVC.h"
#import "HqIdInfoInputView.h"

#define SmsTime 60

@interface HqAddCardInfoVC ()
<UITextFieldDelegate>

@property (nonatomic,strong) HqIdInfoInputView *cardTypeView;
@property (nonatomic,strong) HqIdInfoInputView *cvvInputView;
@property (nonatomic,strong) HqIdInfoInputView *expireView;//截止日期
@property (nonatomic,strong) HqIdInfoInputView *mobileInputView;
@property (nonatomic,strong) HqIdInfoInputView *checkCodeInputView;
@property (nonatomic,copy) NSString *refCode;//用户绑卡的的参数

@property (nonatomic,strong) UIButton *checkBtn;
@property (nonatomic,strong) NSTimer *checkCodeTimer;
@property (nonatomic,assign) int totalTime;

@end

@implementation HqAddCardInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Link Cards";
    [self initView];
}
- (void)initView{
    
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    contentView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+400);
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    
    CGFloat cellHeight = kZoomValue(65);
    CGFloat ySpace = 20;
    CGFloat xInput = kZoomValue(ySpace);
    CGFloat width = SCREEN_WIDTH  - 2*xInput;
    
    _cardTypeView = [[HqIdInfoInputView alloc] initWithFrame:CGRectMake(xInput, kZoomValue(40), width, cellHeight)];
    _cardTypeView.titleLab.text = @"Card Type";
    _cardTypeView.inputView.placeholder = @"Card Type";
    [contentView addSubview:_cardTypeView];
    
    _cvvInputView = [[HqIdInfoInputView alloc] initWithFrame:CGRectMake(xInput, CGRectGetMaxY(_cardTypeView.frame)+kZoomValue(ySpace), width, cellHeight)];
    _cvvInputView.titleLab.text = @"CVV";
    _cvvInputView.inputView.placeholder = @"CVV";
    [contentView addSubview:_cvvInputView];
    
    
    UIButton *dateChooseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    dateChooseBtn.frame =  CGRectMake(0, 0, 40, kZoomValue(45));
    dateChooseBtn.tintColor = COLORA(159,162,164);
    [dateChooseBtn setImage:[UIImage imageNamed:@"down_arrow_icon"] forState:UIControlStateNormal];
    [dateChooseBtn addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:dateChooseBtn];
    
    _expireView = [[HqIdInfoInputView alloc] initWithFrame:CGRectMake(xInput, CGRectGetMaxY(_cvvInputView.frame)+kZoomValue(ySpace), width, cellHeight)];
    _expireView.titleLab.text = @"EXP.Year";
    _expireView.inputView.placeholder = @"EXP.Year";
    _expireView.inputView.delegate = self;
    _expireView.inputView.rightViewMode = UITextFieldViewModeAlways;
    _expireView.inputView.rightView = dateChooseBtn;
    [contentView addSubview:_expireView];
    
    
    _mobileInputView = [[HqIdInfoInputView alloc] initWithFrame:CGRectMake(xInput, CGRectGetMaxY(_expireView.frame)+kZoomValue(ySpace), width, cellHeight)];
    _mobileInputView.titleLab.text = @"Phone";
    _mobileInputView.inputView.placeholder = @"Same as bank records";
    _mobileInputView.inputView.delegate = self;
    [contentView addSubview:_mobileInputView];
    
    _checkCodeInputView = [[HqIdInfoInputView alloc] initWithFrame:CGRectMake(xInput, CGRectGetMaxY(_mobileInputView.frame)+kZoomValue(ySpace), width-kZoomValue(100), cellHeight)];
    _checkCodeInputView.titleLab.text = @"Verfication code";
    _checkCodeInputView.inputView.placeholder = @"Verfication code";
    _checkCodeInputView.inputView.delegate = self;
    [contentView addSubview:_checkCodeInputView];
    
    
    NSString *title = @"Send";
    UIColor *titleColor = [UIColor darkTextColor];
    UIButton *checkCodeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    checkCodeBtn.tintColor = titleColor;
    checkCodeBtn.tintColor = AppMainColor;
    checkCodeBtn.backgroundColor = [UIColor whiteColor];
    [checkCodeBtn setTitle:title forState:UIControlStateNormal];
    [checkCodeBtn addTarget:self action:@selector(geCheckCode:) forControlEvents:UIControlEventTouchUpInside];
    checkCodeBtn.layer.borderWidth = 1.0;
    checkCodeBtn.layer.borderColor = AppMainColor.CGColor;
    checkCodeBtn.layer.cornerRadius = 2.0;

    [contentView addSubview:checkCodeBtn];
    
    [checkCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_checkCodeInputView.mas_bottom);
        make.left.equalTo(_checkCodeInputView.mas_right).offset(kZoomValue(10));
        make.right.equalTo(self.view).offset(-kZoomValue(ySpace));
        make.height.mas_equalTo(kZoomValue(45));
    }];
    
    self.checkBtn = checkCodeBtn;
    
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    nextBtn.tintColor = [UIColor whiteColor];

    nextBtn.frame = CGRectMake(xInput, CGRectGetMaxY(_checkCodeInputView.frame)+kZoomValue(ySpace), width, kZoomValue(45));
    [nextBtn setTitle:@"Next" forState:UIControlStateNormal];
    nextBtn.backgroundColor = COLOR(17, 139, 226, 1);
    nextBtn.layer.cornerRadius = 2.0;
    [nextBtn addTarget:self action:@selector(addCardInfoNextClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:nextBtn];

    
}
- (void)chooseDate:(UIButton *)btn{
    
    
}
- (void)addCardInfoNextClick:(UIButton *)btn{
    
}
- (void)geCheckCode:(UIButton *)btn{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (void)getCheckCode{
    
    /*
    {
        "success": true,
        "code": 1,
        "message": "Successful.",
        "refCode": "R952748984642842624"
    }
    */
    NSString *url = [NSString stringWithFormat:@"/cards/%@/codes/%@",@"cardNum",_mobileInputView.inputView.text];
    [HqHttpUtil hqGetShowHudTitle:nil param:nil url:url complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                _refCode = [responseObject hq_objectForKey:@"refCode"];
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
    
}
- (void)addCard{
    NSDictionary *param = @{
                            @"refCode": _refCode,
                            @"cvv": @"",
                            @"exp": @"string",
                            @"otp": @"string"
                            };
    [HqHttpUtil hqPostShowHudTitle:nil param:param url:@"/cards" complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
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
