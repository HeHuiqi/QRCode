//
//  HqTransferView.h
//  QRCode
//
//  Created by macpro on 2018/2/11.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HqTransferView : UIView

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *titleIconName;
@property (nonatomic,strong) NSString *subCenterTitle;
@property (nonatomic,strong) NSString *productInfo;//转账信息


@property (nonatomic,assign) CGFloat money;

@property (nonatomic,strong) NSDictionary *params;
@property (nonatomic,assign) CGFloat transferMoney;//转账金额
@property (nonatomic,copy) NSString *codeInfo;//二维码信息,直接显示信息


- (void)startGetPayCode;
- (void)stopGetPayCode;


@end
