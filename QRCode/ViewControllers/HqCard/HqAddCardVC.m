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

@interface HqAddCardVC ()<UITextFieldDelegate>

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
    [self.view addSubview:infoLab];
    
    CGFloat height = kZoomValue(45);
    CGFloat contentWidth = SCREEN_WIDTH-2*kZoomValue(20);
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(kZoomValue(space), CGRectGetMaxY(infoLab.frame)+kZoomValue(5), contentWidth, height*2+3)];
    contentView.layer.borderWidth = 1.0;
    contentView.layer.cornerRadius = 2.0;
    [self.view addSubview:contentView];
    
    _nameTf = [[HqInputView alloc] initWithPlacehoder:@"No." leftIcon:@""];
    _nameTf.text = @"哈哈过";
//    _nameTf.delegate = self;
    _nameTf.userInteractionEnabled = NO;
    [contentView addSubview:_nameTf];
    [_nameTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(1.0);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.mas_equalTo(height);
    }];
    UIView *xline = [[UIView alloc] init];
    xline.backgroundColor = [UIColor blackColor];
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
    photoBtn.tintColor = [UIColor whiteColor];
    [photoBtn setTitle:@"photo" forState:UIControlStateNormal];
    photoBtn.backgroundColor = COLOR(17, 139, 226, 1);
    [photoBtn addTarget:self action:@selector(photo:) forControlEvents:UIControlEventTouchUpInside];
    
    _cardNumberTf = [[HqInputView alloc] initWithPlacehoder:@"Name" leftIcon:@""];
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
    nextBtn.layer.cornerRadius = 2.0;
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
    NSLog(@"2323236");
}
- (void)cardNextClick:(UIButton *)btn{
    HqAddCardInfoVC *addCardInfoVC = [[HqAddCardInfoVC alloc] init];
    Push(addCardInfoVC);
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
