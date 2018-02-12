//
//  HqTransferSetMoneyVC.m
//  QRCode
//
//  Created by macpro on 2018/2/11.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqTransferSetMoneyVC.h"
#import "HqTransferVC.h"

@interface HqTransferSetMoneyVC ()<UITextFieldDelegate>

@property (nonatomic,strong) HqIdInfoInputView *amountTf;
@property (nonatomic,strong) HqIdInfoInputView *markTf;

@end

@implementation HqTransferSetMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
- (void)initView{
    self.title = @"Transfer account";
    UIView *contentView = self.view;
    CGFloat inputHeight = 65;
    CGFloat leftSpace = 20;
    
    _amountTf = [[HqIdInfoInputView alloc] init];
    _amountTf.titleLab.text = @"Amount";
    _amountTf.inputView.delegate = self;
    _amountTf.inputView.keyboardType = UIKeyboardTypeNumberPad;
    _amountTf.layer.cornerRadius = kHqCornerRadius;
    [contentView addSubview:_amountTf];
    
    [_amountTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
        make.top.equalTo(contentView).offset(64+kZoomValue(80));
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    
    _markTf = [[HqIdInfoInputView alloc] init];
    _markTf.titleLab.text = @"Mark";
    _markTf.inputView.delegate = self;
    _markTf.layer.cornerRadius = kHqCornerRadius;
    [contentView addSubview:_markTf];
    
    [_markTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(leftSpace));
        make.right.equalTo(contentView).offset(-kZoomValue(leftSpace));
        make.top.equalTo(_amountTf.mas_top).offset(kZoomValue(leftSpace));
        make.height.mas_equalTo(kZoomValue(inputHeight));
    }];
    [self tapView:self.view];
}
- (void)tapView:(UIView *)view{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [view addGestureRecognizer:tap];
}
- (void)tapGesture:(UITapGestureRecognizer *)tap{
    
    HqTransferVC *transferVC = [[HqTransferVC alloc] init];
    transferVC.pesonTransferType = 2;
    HqTransfer *transfer = [[HqTransfer alloc] init];
    transfer.amount = 50;
    transfer.payer = @"哈哈哈哈";
    transferVC.transfer = transfer;
    Push(transferVC);
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
