//
//  HqBankCard.h
//  QRCode
//
//  Created by macpro on 2018/1/12.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {
 "id": 1,
 "cardNumber": "6225885216864223",
 "bankName": "招商银行",
 "bankCode": "03080000",
 "type": 0,
 "cvv": "235",
 "exp": "1221",
 "realName": "周璐璐",
 "idType": "01",
 "idNumber": "340621199003037874",
 "mobile": "17721167674",
 "lastDigits": "4223",
 "token": "8888123456780001",
 "tokenExpiry": "9999",
 "par": "99991712070938686546385575936",
 "isDefault": 1,
 "createTime": "2017-12-07T00:28:07.000Z",
 "updateTime": "2017-12-07T00:28:07.000Z"
 }
 */
typedef NS_ENUM(NSUInteger, HqBankcardType) {
    HqBankcardTypeDebit,
    HqBankcardTypeCredit,
    HqBankcardTypeOther,
};

@interface HqBankCard : NSObject

@property (nonatomic,copy) NSString *bankName;
@property (nonatomic,copy) NSString *cardNumber;
@property (nonatomic,copy) NSString *realName;//持卡人姓名
@property (nonatomic,assign) BOOL isDefault;//是否为默认卡
@property (nonatomic,assign) NSInteger type;//卡类型
@property (nonatomic,copy) NSString *cvv;
@property (nonatomic,copy) NSString *exp;


@end
