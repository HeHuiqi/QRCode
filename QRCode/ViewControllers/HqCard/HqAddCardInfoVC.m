//
//  HqAddCardInfoVC.m
//  QRCode
//
//  Created by hehuiqi on 2018/1/6.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqAddCardInfoVC.h"
#import "HqIdInfoInputView.h"
#import "HqPickerView.h"
#define SmsTime 60
#import "HqPayPasswordVC.h"


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
@property (nonatomic,strong) UILabel *countLab;
@property (nonatomic,assign) int totalTime;

@end

@implementation HqAddCardInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Link Cards";
    [self initView];
    _totalTime = 60;
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
    
    if (_cardType == HqBankcardTypeDebit ) {
        _cardTypeView.inputView.text = @"Debit Card";
    }else if(_cardType == HqBankcardTypeCredit){
        _cardTypeView.inputView.text = @"Credit Card";
    }else{
        _cardTypeView.inputView.text = @"Other";
    }
    
    CGRect mobileRect = CGRectZero;
    if (_cardType == HqBankcardTypeCredit) {
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
        mobileRect = CGRectMake(xInput, CGRectGetMaxY(_expireView.frame)+kZoomValue(ySpace), width, cellHeight);
    }else{
         mobileRect = CGRectMake(xInput, CGRectGetMaxY(_cardTypeView.frame)+kZoomValue(ySpace), width, cellHeight);
    }
    _mobileInputView = [[HqIdInfoInputView alloc] initWithFrame:mobileRect];
    _mobileInputView.titleLab.text = @"Phone";
    _mobileInputView.inputView.placeholder = @"Same as bank records";
    _mobileInputView.inputView.delegate = self;
    _mobileInputView.inputView.keyboardType = UIKeyboardTypeNumberPad;
    [contentView addSubview:_mobileInputView];
    
    _checkCodeInputView = [[HqIdInfoInputView alloc] initWithFrame:CGRectMake(xInput, CGRectGetMaxY(_mobileInputView.frame)+kZoomValue(ySpace), width-kZoomValue(100), cellHeight)];
    _checkCodeInputView.titleLab.text = @"Verfication code";
    _checkCodeInputView.inputView.placeholder = @"Verfication code";
    _checkCodeInputView.inputView.delegate = self;
    _checkCodeInputView.inputView.keyboardType = UIKeyboardTypeNumberPad;
    [contentView addSubview:_checkCodeInputView];
    
    
    NSString *title = @"Send";
    UIButton *checkCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkCodeBtn setTitle:title forState:UIControlStateNormal];
    [checkCodeBtn setTitleColor:AppMainColor forState:UIControlStateNormal];
    [checkCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [checkCodeBtn setBackgroundImage:[UIImage imageNamed:@"btn_border"] forState:UIControlStateNormal];
    [checkCodeBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateHighlighted];
    [checkCodeBtn addTarget:self action:@selector(geCheckCode:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:checkCodeBtn];
    self.checkBtn = checkCodeBtn;
    self.checkBtn.hidden = YES;
    
    [checkCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_checkCodeInputView.mas_bottom);
        make.left.equalTo(_checkCodeInputView.mas_right).offset(kZoomValue(10));
        make.right.equalTo(self.view).offset(-kZoomValue(ySpace));
        make.height.mas_equalTo(kZoomValue(45));
    }];
    
    _countLab = [[UILabel alloc] init];
    _countLab.textAlignment = NSTextAlignmentCenter;
    _countLab.text = @"Send";
    _countLab.font = [UIFont systemFontOfSize:16];
    _countLab.textColor  = HqGrayColor;
    _countLab.backgroundColor = COLORA(241,245,247);
    [contentView addSubview:_countLab];
    [_countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_checkCodeInputView.mas_bottom);
        make.left.equalTo(_checkCodeInputView.mas_right).offset(kZoomValue(10));
        make.right.equalTo(self.view).offset(-kZoomValue(ySpace));
        make.height.mas_equalTo(kZoomValue(45));
    }];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    nextBtn.tintColor = [UIColor whiteColor];

    nextBtn.frame = CGRectMake(xInput, CGRectGetMaxY(_checkCodeInputView.frame)+kZoomValue(ySpace), width, kZoomValue(45));
    [nextBtn setTitle:@"Next" forState:UIControlStateNormal];
    nextBtn.backgroundColor = COLOR(17, 139, 226, 1);
    nextBtn.layer.cornerRadius = kHqCornerRadius;
    [nextBtn addTarget:self action:@selector(addCardInfoNextClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:nextBtn];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:_mobileInputView.inputView];

    
}
- (void)getCheckCodeTimer{
    _totalTime--;
    NSString *title = [NSString stringWithFormat:@"Send(%ds)",_totalTime];
    if (_totalTime == 0)
    {
        [self destroyTimer];
        title = @"Send";
        [self hidenBtnView:NO];
    }else{
        [self hidenBtnView:YES];
    }
    _countLab.text = title;
}
- (void)destroyTimer
{
    [_checkCodeTimer invalidate];
    _checkCodeTimer = nil;
    _totalTime = 60;
    [self hidenBtnView:NO];
    
}
#pragma mark - 输入变化通知方法
- (void)textChange:(NSNotification *)nofit{
    if ([nofit.object isEqual:_mobileInputView.inputView]) {
//        BOOL isFull = _mobileInputView.inputView.text.length==kMobileNumberLength;
        BOOL isFull = [NSString isMobileNumber:_mobileInputView.inputView.text];
        [self hidenBtnView:!isFull];
    }
}
- (void)hidenBtnView:(BOOL)hide{
    _checkBtn.hidden = hide;
    _countLab.hidden = !hide;
}

- (void)chooseDate:(UIButton *)btn{
    HqPickerView *pick = [[HqPickerView alloc]init];
    pick.isSetYearMonth = YES;
    pick.monthData = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12];
    pick.yearData = [self years];
    pick.title = @"Choose Date";
    pick.cancelTitle = @"Cancel";
    pick.confirmTitle = @"Confirm";
    [pick.pickerView selectRow:pick.yearData.count/2 inComponent:0 animated:NO];
    [pick.pickerView selectRow:pick.monthData.count/2 inComponent:1 animated:NO];
    [pick showPikerViewWithBlock:^(NSString *text) {
        NSLog(@"text = %@",text);
        _expireView.inputView.text = [self showDate:text];
    }];
}
- (NSString *)showDate:(NSString *)date{
    HqDateFormatter *dateFormat = [HqDateFormatter shareInstance];
    date = [dateFormat dateString:date orginalFormat:@"yyyy-MM" resultFormat:@"MMyy"];
    return date;
}
- (NSArray *)years{
    HqDateFormatter *dateFormat = [HqDateFormatter shareInstance];
    NSString *currentStr =  [dateFormat dateStringWithFormat:@"yyyy" date:[NSDate date]];
    NSMutableArray *myYears = [NSMutableArray array];
    for (int i = currentStr.intValue; i<=currentStr.intValue+100; i++) {
        @autoreleasepool {
            [myYears addObject:@(i)];
        }
    }
    return myYears;
}
- (void)addCardInfoNextClick:(UIButton *)btn{
    
//    [self backToVC:@"HqCardsVC"];
    [self addCard];
}
- (void)geCheckCode:(UIButton *)btn{
    
    if(_mobileInputView.inputView.text.length==0){
        [Dialog simpleToast:@"The phone number can't be empty"];
        return;
    }
    BOOL isNumber = [NSString isMobileNumber:_mobileInputView.inputView.text];
    if(_mobileInputView.inputView.text.length<kMobileNumberMinLength||!isNumber){
        [Dialog simpleToast:@"Incorrect phone number"];
        return;
    }
    
    [self destroyTimer];
    if (_checkCodeTimer == nil)
    {
        _checkCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getCheckCodeTimer) userInfo:nil repeats:YES];
    }
    [self requestCheckCode];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (void)requestCheckCode{
    
    /*
    {
        "success": true,
        "code": 1,
        "message": "Successful.",
        "refCode": "R952748984642842624"
    }
    */
    NSString *url = [NSString stringWithFormat:@"/cards/%@/codes/%@",_cardNumber,_mobileInputView.inputView.text];
    [HqHttpUtil hqGetShowHudTitle:nil param:nil url:url complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                _refCode = [responseObject hq_objectForKey:@"refCode"];
            }else{
                [self destroyTimer];
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
            [self destroyTimer];
        }
    }];
    
}
#pragma mark - 开始添加
- (void)addCard{
    if(_mobileInputView.inputView.text.length==0){
        [Dialog simpleToast:@"The phone number can't be empty"];
        return;
    }
    
    BOOL isNumber = [NSString isMobileNumber:_mobileInputView.inputView.text];
    if(_mobileInputView.inputView.text.length<kMobileNumberMinLength||!isNumber){
        [Dialog simpleToast:@"Incorrect phone number"];
        return;
    }
    
    if(_checkCodeInputView.inputView.text.length==0){
        [Dialog simpleToast:@"The verfication code can't be empty"];
        return;
    }
    if(_checkCodeInputView.inputView.text.length<6){
        [Dialog simpleToast:@"The verfication code length 6 "];
        return;
    }
    NSString *otp = _checkCodeInputView.inputView.text;

    NSDictionary *param = @{
                            @"refCode": _refCode,
                            @"otp": otp
                            };
    if (_cardType == HqBankcardTypeCredit) {
        
        NSString *exp = _expireView.inputView.text;
        NSString *cvv = _cvvInputView.inputView.text;
        if (!exp) {
            exp = @"";
        }
        if (!cvv) {
            cvv = @"";
        }
        param = @{
                  @"refCode": _refCode,
                  @"cvv": cvv,
                  @"exp": exp,
                  @"otp": otp
                  };
    }
   
    [HqHttpUtil hqPostShowHudTitle:nil param:param url:@"/cards" complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        if (response.statusCode == 200) {
            NSLog(@"添加银行卡===%@",responseObject);
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kAddBankCardSuccess object:nil];
                if (!_user.hasPin) {
                    HqPayPasswordVC *passwordVC = [[HqPayPasswordVC alloc] init];
                    passwordVC.payPasswordType = HqPayPasswordCreate;
                    passwordVC.isFromAddCardInfo = 1;
                    Push(passwordVC);
                }else{
                    [self backToVC:@"HqCardsVC"];
                }
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if ([textField isEqual:_mobileInputView.inputView]) {
        if (textField.text.length >=kMobileNumberLength) {
            return NO;
        }
    }
    
    if ([textField isEqual:_checkCodeInputView.inputView]) {
        if (textField.text.length >=kCheckCodeMaxLength) {
            return NO;
        }
    }
    return YES;
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
