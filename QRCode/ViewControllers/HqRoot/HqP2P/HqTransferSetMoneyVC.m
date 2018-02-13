//
//  HqTransferSetMoneyVC.m
//  QRCode
//
//  Created by macpro on 2018/2/11.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqTransferSetMoneyVC.h"
#import "HqTransferConfirmVC.h"
@interface HqTransferSetMoneyVC ()<UITextFieldDelegate,HqConfirmPayViewDelegate>

@property (nonatomic,strong) HqIdInfoInputView *amountTf;
@property (nonatomic,strong) HqIdInfoInputView *markTf;
@property (nonatomic,strong) HqConfirmPayView *confirmPayView;



@end

@implementation HqTransferSetMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
- (HqConfirmPayView *)confirmPayView{
    
    if (!_confirmPayView) {
        _confirmPayView = [[HqConfirmPayView alloc] init];
        _confirmPayView.delegate = self;
    }
    return _confirmPayView;
}
- (void)initView{
    self.title = @"Transfer amount";
    UIView *contentView = self.view;
    CGFloat inputHeight = 65;
    CGFloat leftSpace = 20;
    contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.isShowBottomLine = YES;
    
    _amountTf = [[HqIdInfoInputView alloc] init];
    _amountTf.titleLab.text = @"Amount";
    _amountTf.inputView.delegate = self;
    _amountTf.inputView.placeholder = @"Please input amount";
    _amountTf.inputView.keyboardType = UIKeyboardTypeDecimalPad;

    _amountTf.layer.cornerRadius = kHqCornerRadius;
    [contentView addSubview:_amountTf];
    
    [_amountTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
        make.top.equalTo(contentView).offset(64+kZoomValue(33));
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.tintColor = [UIColor whiteColor];
    [loginBtn setTitle:@"Confirm" forState:UIControlStateNormal];
    loginBtn.backgroundColor = COLOR(17, 139, 226, 1);
    [loginBtn addTarget:self action:@selector(comfirm:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.layer.cornerRadius = kHqCornerRadius;
    [contentView addSubview:loginBtn];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.top.equalTo(_amountTf.mas_bottom).offset(kZoomValue(15));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
        make.height.mas_equalTo(kZoomValue(45));
    }];
    
}
- (void)comfirm:(UIButton *)btn{
    
    if ([_amountTf.inputView.text floatValue]==0) {
        [Dialog simpleToast:@"Please Input Correct Number!"];
        return;
    }
    if ([_amountTf.inputView.text floatValue]>10000) {
        [Dialog simpleToast:@"Input Number too large!"];
        return;
    }
    if (_transferType == 1) {
        _transfer.amount =  [_amountTf.inputView.text floatValue];
        HqTransferConfirmVC *tcfVC = [[HqTransferConfirmVC alloc] init];
        tcfVC.transfer = _transfer;
        Push(tcfVC);
        return;
    }
    if (_transferType == 2) {
        [self.confirmPayView showPayView];
    }

}
#pragma mark - HqConfirmPayViewDelegate
- (void)hqConfirmPayView:(HqConfirmPayView *)payView password:(NSString *)password{
    
    [payView dismissPayView];
    NSLog(@"password == %@",password);
    password = [NSString sha1:password];
    NSLog(@"password1 == %@",password);
    
    HqTransfer *transfer = [[HqTransfer alloc] init];
    transfer.amount = [_amountTf.inputView.text floatValue];
    transfer.pin = password;
    transfer.currency = @"VND";
    if (self.delegate) {
        [self.delegate hqTransferSetMoneyVC:self transfer:transfer];
        Back();
    }
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
