//
//  HqBillCell.h
//  QRCode
//
//  Created by macpro on 2018/1/19.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HqBillCell : UITableViewCell

@property (nonatomic,strong) UIImageView *leftIcon;

@property (nonatomic,strong) UILabel *merchantNameLab;
@property (nonatomic,strong) UILabel *payTimeLab;

@property (nonatomic,strong) UILabel *payamountLab;

@property (nonatomic,strong) HqBill *bill;

@end
