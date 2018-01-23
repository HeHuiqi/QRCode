//
//  HqComfirmPayView.h
//  QRCode
//
//  Created by macpro on 2018/1/23.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HqConfirmPayViewDelegate;
@interface HqConfirmPayView : UIView

@property (nonatomic,assign) id<HqConfirmPayViewDelegate> delegate;
@property (nonatomic,strong) UIButton *closeBtn;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIButton *forgetBtn;
@property (nonatomic,strong) HqPassWordView *passwordView;

- (void)showPayView;
- (void)dismissPayView;

@end

@protocol HqConfirmPayViewDelegate

- (void)hqConfirmPayView:(HqConfirmPayView *)payView password:(NSString *)password;

@end

