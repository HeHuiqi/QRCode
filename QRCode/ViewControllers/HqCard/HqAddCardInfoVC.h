//
//  HqAddCardInfoVC.h
//  QRCode
//
//  Created by hehuiqi on 2018/1/6.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "SuperVC.h"

@interface HqAddCardInfoVC : SuperVC


@property (nonatomic,assign) HqBankcardType cardType;
@property (nonatomic,copy) NSString *cardNumber;
@property (nonatomic,strong) HqUser *user;


@end
