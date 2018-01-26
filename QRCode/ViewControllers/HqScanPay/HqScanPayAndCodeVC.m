//
//  HqScanPayAndCodeVC.m
//  QRCode
//
//  Created by macpro on 2018/1/19.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqScanPayAndCodeVC.h"
#import "SGQRCode.h"
#import "HqMyPayCodeView.h"
#import "HqButton.h"
#import "HqPayVC.h"
#import "HqScanResultVC.h"
#define HqBottomHeight  kZoomValue(80)
@interface HqScanPayAndCodeVC ()<SGQRCodeScanManagerDelegate, SGQRCodeAlbumManagerDelegate>

@property (nonatomic, strong) SGQRCodeScanManager *manager;
@property (nonatomic, strong) SGQRCodeScanningView *scanningView;
@property (nonatomic, strong) UIButton *flashlightBtn;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, assign) BOOL isSelectedFlashlightBtn;

@property (nonatomic,strong) HqButton *selectBtn;//选中btn
@property (nonatomic,strong) HqMyPayCodeView *payCodeView;
@property (nonatomic,assign) BOOL isReaded;//已经读取成功


@end

@implementation HqScanPayAndCodeVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanningView addTimer];
    [_manager resetSampleBufferDelegate];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanningView removeTimer];
    [self removeFlashlightBtn];
    [_manager cancelSampleBufferDelegate];
    
}
- (HqMyPayCodeView *)payCodeView{
    if (!_payCodeView) {
        _payCodeView = [[HqMyPayCodeView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,  self.view.frame.size.height-64-HqBottomHeight)];
        _payCodeView.backgroundColor = AppMainColor;
    }
    return _payCodeView;
}
- (void)dealloc {
    [self removeScanningView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Pay";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.scanningView];
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        NSLog(@"%@",granted ? @"相机准许":@"相机不准许");
        if (granted) {
            [self setupQRCodeScanning];
        }else{
            HqAlertView *alert = [[HqAlertView alloc] initWithTitle:@"Request Open Camera" message:nil];
            alert.btnTitles = @[@"Cancel",@"Confirm"];
            [alert showVC:self callBack:^(UIAlertAction *action, int index) {
                if (index == 1) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }else{
//                    Back();
                }
                
            }];
        }
        
    }];
    [self.view addSubview:self.promptLabel];
    [self.view addSubview:self.flashlightBtn];
    [self.view addSubview:self.payCodeView];
    
    self.payCodeView.hidden = YES;
    [self bottomView];
    [self getPayCode];
    self.isReaded = NO;
}


- (SGQRCodeScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [[SGQRCodeScanningView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,  self.view.frame.size.height-64-HqBottomHeight)];
        /*
         _scanningView.scanningImageName = @"SGQRCode.bundle/QRCodeScanningLineGrid";
         _scanningView.scanningAnimationStyle = ScanningAnimationStyleGrid;
         _scanningView.cornerColor = [UIColor orangeColor];
         */
    }
    return _scanningView;
}
- (void)removeScanningView {
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}
- (void)setupQRCodeScanning {
    self.manager = [SGQRCodeScanManager sharedManager];
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    [_manager setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    //    [manager cancelSampleBufferDelegate];
    _manager.delegate = self;
}

#pragma mark - - - SGQRCodeAlbumManagerDelegate
//从相册读取
- (void)QRCodeAlbumManagerDidCancelWithImagePickerController:(SGQRCodeAlbumManager *)albumManager {
    [self.view addSubview:self.scanningView];
}
- (void)QRCodeAlbumManager:(SGQRCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result {
    
    NSLog(@"result==%@",result);
}
//扫描读取
#pragma mark - - - SGQRCodeScanManagerDelegate
- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    NSLog(@"metadataObjects - - %@", metadataObjects);
    if (self.isReaded) {
        return;
    }
    if (metadataObjects != nil && metadataObjects.count > 0) {
        [scanManager palySoundName:@"SGQRCode.bundle/sound.caf"];
        [scanManager stopRunning];
        [scanManager videoPreviewLayerRemoveFromSuperlayer];
        self.isReaded = YES;
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        NSLog(@"obj===%@",obj.stringValue);
        if (obj.stringValue) {
            [self scanSuccess:obj.stringValue];
        }
        
    } else {
        NSLog(@"暂未识别出扫描的二维码");
    }
}
- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager brightnessValue:(CGFloat)brightnessValue {
    if (brightnessValue < - 1) {
        [self.view addSubview:self.flashlightBtn];
    } else {
        if (self.isSelectedFlashlightBtn == NO) {
            [self removeFlashlightBtn];
        }
    }
}

- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.backgroundColor = [UIColor clearColor];
        CGFloat promptLabelX = 0;
        CGFloat promptLabelY = 0.73 * self.view.frame.size.height+20;
        CGFloat promptLabelW = self.view.frame.size.width;
        CGFloat promptLabelH = 25;
        _promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _promptLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        _promptLabel.text = @"Scan automaticaly within the frame";
    }
    return _promptLabel;
}


#pragma mark - - - 闪光灯按钮
- (UIButton *)flashlightBtn {
    if (!_flashlightBtn) {
        // 添加闪光灯按钮
        _flashlightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        CGFloat flashlightBtnW = 30;
        CGFloat flashlightBtnH = 30;
        CGFloat flashlightBtnX = 0.5 * (self.view.frame.size.width - flashlightBtnW);
        CGFloat flashlightBtnY = 0.55 * self.view.frame.size.height;
        _flashlightBtn.frame = CGRectMake(flashlightBtnX, flashlightBtnY, flashlightBtnW, flashlightBtnH);
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"SGQRCodeFlashlightOpenImage"] forState:(UIControlStateNormal)];
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"SGQRCodeFlashlightCloseImage"] forState:(UIControlStateSelected)];
        [_flashlightBtn addTarget:self action:@selector(flashlightBtn_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashlightBtn;
}

- (void)flashlightBtn_action:(UIButton *)button {
    if (button.selected == NO) {
        [SGQRCodeHelperTool SG_openFlashlight];
        self.isSelectedFlashlightBtn = YES;
        button.selected = YES;
    } else {
        [self removeFlashlightBtn];
    }
}

- (void)removeFlashlightBtn {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SGQRCodeHelperTool SG_CloseFlashlight];
        self.isSelectedFlashlightBtn = NO;
        self.flashlightBtn.selected = NO;
        [self.flashlightBtn removeFromSuperview];
    });
}
- (void)bottomView{
    CGFloat viewHeight = HqBottomHeight;
    UIView *bottom = [[UIView alloc] init];
    bottom.backgroundColor = AppMainColor;
    [self.view addSubview:bottom];
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.mas_equalTo(viewHeight);
    }];
    NSArray *titles = @[@"Scan Pay",@"Payment Code"];
    NSArray *images = @[@"pay_scan_icon",@"pay_code_icon"];
    for (int i = 0; i<titles.count; i++) {
        CGFloat width = SCREEN_WIDTH/titles.count;
        HqButton *button = [[HqButton alloc] initWithFrame:CGRectMake(i*width, 0, width, viewHeight)];
        button.isSetHighlighted = NO;
        button.iconImage = [UIImage imageNamed:images[i]];
        button.title = titles[i];
        if (i == 0) {
            _selectBtn = button;
            _selectBtn.selected = YES;
        }
        [button addTarget:self action:@selector(bottomClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+1;
        [bottom addSubview:button];
    }

}
- (void)bottomClick:(HqButton *)btn{
    
    if (![btn isEqual:_selectBtn]) {
        btn.selected = YES;
        _selectBtn.selected = NO;
        _selectBtn = btn;
    }
    if (btn.tag == 1) {
        _payCodeView.hidden = YES;
        _scanningView.hidden = NO;
    }else{
        _payCodeView.hidden = NO;
        _scanningView.hidden = YES;
    }
    
    
}
#pragma mark - 扫码成功
- (void)scanSuccess:(NSString *)collectCode{
//    HqPayVC *payVC = [[HqPayVC alloc] init];
//    payVC.code = collectCode;
//    payVC.isFromScan = 1;
//    Push(payVC);
    NSDictionary *param = @{@"collectCode": collectCode};
    [HqHttpUtil hqPostShowHudTitle:nil param:param url:@"/transactions/collectCodes/getOrder" complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"获取订单信息==%@",responseObject);
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                NSDictionary *orderDic = [responseObject hq_objectForKey:@"orderInfo"];
                HqBill *bill = [HqBill mj_objectWithKeyValues:orderDic];
                HqPayVC *payVC = [[HqPayVC alloc] init];
                payVC.code = collectCode;
                payVC.isFromScan = 1;
                payVC.bill = bill;
                Push(payVC);
            }else{
                [Dialog simpleToast:msg];
                HqScanResultVC *resultVC = [[HqScanResultVC alloc] init];
                resultVC.result = collectCode;
                Push(resultVC);
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
}
- (void)getPayCode{
    
    [HqHttpUtil hqPost:nil url:@"/transactions/codes" complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"==%@",responseObject);
        
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                NSString *payCode = [responseObject hq_objectForKey:@"payCode"];
                if (payCode.length>0) {
                    self.payCodeView.payCodeInfo = payCode;
                }
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
}
@end
