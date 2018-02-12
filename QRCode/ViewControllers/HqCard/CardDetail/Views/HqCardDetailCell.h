//
//  HqCardDetailCell.h
//  QRCode
//
//  Created by macpro on 2018/1/18.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqCardInfoView.h"

@interface HqCardDetailCell : UITableViewCell

@property (nonatomic,strong) UIImageView *bankIcon;
@property (nonatomic,strong) UILabel *bankNameLab;
@property (nonatomic,strong) UILabel *cardTypeLab;
@property (nonatomic,strong) UILabel *cardNumberLab;
@property (nonatomic,strong) HqCardInfoView *dateView;
@property (nonatomic,strong) HqCardInfoView *cvvView;

@property (nonatomic,strong) HqBankCard *bankCard;


@end
