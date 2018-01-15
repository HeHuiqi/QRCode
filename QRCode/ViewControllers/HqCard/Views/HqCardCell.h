//
//  HqCardCell.h
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HqCardCell : UITableViewCell

@property (nonatomic,strong) UILabel *bankNameLab;
@property (nonatomic,strong) UILabel *cardTypeLab;
@property (nonatomic,strong) UILabel *cardNumberLab;

@property (nonatomic,strong) HqBankCard *bankCard;

@end
