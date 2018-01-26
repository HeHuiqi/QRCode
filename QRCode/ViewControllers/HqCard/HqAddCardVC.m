//
//  HqAddCardVC.m
//  QRCode
//
//  Created by hehuiqi on 2018/1/6.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqAddCardVC.h"
#import "HqInputView.h"
#import "HqAddCardInfoVC.h"
#import "HqGesturePasswordVC.h"
#import <CardIO/CardIO.h>
#import <AVFoundation/AVFoundation.h>
@interface HqAddCardVC ()<UITextFieldDelegate,CardIOPaymentViewControllerDelegate>

@property (nonatomic,strong) HqInputView *nameTf;
@property (nonatomic,strong) HqInputView *cardNumberTf;

@end

@implementation HqAddCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
- (void)initView{
    
    CGFloat space = 20;
    self.title = @"Link Cards";
    UILabel *infoLab = [[UILabel alloc] initWithFrame:CGRectMake(kZoomValue(space), CGRectGetMaxY(self.navBarView.frame)+40, SCREEN_WIDTH-60, 13)];
    infoLab.font = [UIFont systemFontOfSize:kZoomValue(12)];
    infoLab.text = @"Please add your own card";
    infoLab.textColor = HqGrayColor;
    [self.view addSubview:infoLab];
    
    UIColor *borderColor = COLORA(230,230,230);
    CGFloat height = kZoomValue(45);
    CGFloat contentWidth = SCREEN_WIDTH-2*kZoomValue(20);
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(kZoomValue(space), CGRectGetMaxY(infoLab.frame)+kZoomValue(5), contentWidth, height*2+3)];
    contentView.layer.borderWidth = 1.0;
    contentView.layer.borderColor = borderColor.CGColor;
    contentView.layer.cornerRadius = 2.0;
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    
    _nameTf = [[HqInputView alloc] initWithPlacehoder:@"name" leftIcon:@"card_people_icon"];
    _nameTf.text = _user.realName;
//    _nameTf.delegate = self;
//    _nameTf.userInteractionEnabled = NO;
    [contentView addSubview:_nameTf];
    [_nameTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(1.0);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.mas_equalTo(height);
    }];
    UIView *xline = [[UIView alloc] init];
    xline.backgroundColor = borderColor;
    [contentView addSubview:xline];
    [xline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.centerY.equalTo(contentView);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.mas_equalTo(1.0);
    }];
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    photoBtn.frame =  CGRectMake(0, 0, 50, kZoomValue(45));
    photoBtn.tintColor = AppMainColor;
    [photoBtn setImage:[UIImage imageNamed:@"card_photo_icon"] forState:UIControlStateNormal];
    [photoBtn addTarget:self action:@selector(photo:) forControlEvents:UIControlEventTouchUpInside];
    
    _cardNumberTf = [[HqInputView alloc] initWithPlacehoder:@"No." leftIcon:@"link_card_icon"];
    [contentView addSubview:_cardNumberTf];
    _cardNumberTf.delegate = self;
    _cardNumberTf.rightViewMode = UITextFieldViewModeAlways;
    _cardNumberTf.rightView = photoBtn;
    [_cardNumberTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(xline.mas_bottom).offset(0);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.mas_equalTo(height);
    }];
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    nextBtn.tintColor = [UIColor whiteColor];
    [nextBtn setTitle:@"Next" forState:UIControlStateNormal];
    nextBtn.backgroundColor = COLOR(17, 139, 226, 1);
    nextBtn.layer.cornerRadius = kHqCornerRadius;
    [nextBtn addTarget:self action:@selector(cardNextClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kZoomValue(space));
        make.top.equalTo(_cardNumberTf.mas_bottom).offset(kZoomValue(space));
        make.right.equalTo(self.view).offset(-kZoomValue(space));
        make.height.mas_equalTo(kZoomValue(kZoomValue(45)));
    }];
}
- (void)photo:(UIButton *)btn{
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        NSLog(@"%@",granted ? @"相机准许":@"相机不准许");
        if (granted) {
            [self startScanCard];
        }else{
            HqAlertView *alert = [[HqAlertView alloc] initWithTitle:@"Request Open Camera" message:nil];
            alert.btnTitles = @[@"Cancel",@"Confirm"];
            [alert showVC:self callBack:^(UIAlertAction *action, int index) {
                if (index == 1) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }
            }];
        }
        
    }];
}
- (void)cardNextClick:(UIButton *)btn{
    
//    HqAddCardInfoVC *addCardInfoVC = [[HqAddCardInfoVC alloc] init];
//    addCardInfoVC.cardType = HqBankcardTypeCredit;
//    Push(addCardInfoVC);
    
//    _cardNumberTf.text = @"6228480402564890018";
    
    [self.view endEditing:YES];
    if (_nameTf.text.length==0) {
        [Dialog simpleToast:@"The name can't be empty!"];
        return;
    }
    if (_cardNumberTf.text.length==0) {
        [Dialog simpleToast:@"The card number can't be empty!"];
        return;
    }
    
    [self checkCardInfo];
}
#pragma mark - UITextFieldDelegate
/*
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:_nameTf]) {
        return NO;
    }
    return YES;
}
*/

#pragma mark - 获取卡信息
- (void)checkCardInfo{
    NSString *url = [NSString stringWithFormat:@"/cards/%@/checking",_cardNumberTf.text];
    [HqHttpUtil hqPostShowHudTitle:nil param:nil url:url complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"检查卡是否已绑定===%@",responseObject);
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                 int cardType = [[responseObject hq_objectForKey:@"cardType"] intValue];
                HqAddCardInfoVC *addCardInfoVC = [[HqAddCardInfoVC alloc] init];
                addCardInfoVC.cardType = cardType;
                addCardInfoVC.user = _user;
                addCardInfoVC.cardNumber = _cardNumberTf.text;
                Push(addCardInfoVC);
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
}
- (void)backClick{
    [self backToVC:@"HqCardsVC"];
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

- (void)startScanCard{
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    scanViewController.disableManualEntryButtons = YES;//不显示右边按钮
    scanViewController.suppressScanConfirmation = YES;//立即返回
    // 进行简单的设置
    scanViewController.hideCardIOLogo = YES;
    scanViewController.collectCVV = NO;
    scanViewController.guideColor = AppMainColor;
    scanViewController.collectExpiry = NO;
    [self presentViewController:scanViewController animated:YES completion:nil];
}
#pragma mark - CardIOPaymentViewControllerDelegate
- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController{
    [paymentViewController dismissViewControllerAnimated:YES completion:nil];
}
- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)cardInfo inPaymentViewController:(CardIOPaymentViewController *)paymentViewController{
    //扫描结果
    //    NSLog(@"Received card info. Number: %@, expiry: %02ld/%ld, cvv: %@-%@", cardInfo.cardNumber, (unsigned long)cardInfo.expiryMonth, (unsigned long)cardInfo.expiryYear, cardInfo.cvv);
    NSLog(@"cardNumber == %@",cardInfo.cardNumber);
    _cardNumberTf.text = cardInfo.cardNumber;
    // 这里可以自己进行一些处理
    ///
    [paymentViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
