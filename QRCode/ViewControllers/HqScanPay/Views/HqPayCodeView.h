//
//  HqPayCodeView.h
//  QRCode
//
//  Created by macpro on 2018/2/11.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,HqPayCodeType) {
    HqPayCodeTypeMyself,//用户商户收款
    HqPayCodeTypeTransfer,//用于客户端相互收付款
};

@interface HqPayCodeView : UIView

@property (nonatomic,assign) HqPayCodeType payCodeType;
@property (nonatomic,copy) NSString *codeUrl;
@property (nonatomic,strong) NSDictionary *params;

@property (nonatomic,copy) NSString *payCodeInfo;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,assign) BOOL isAutoRefresh;//默认YES


- (void)startGetPayCode;
- (void)stopGetPayCode;

@end
