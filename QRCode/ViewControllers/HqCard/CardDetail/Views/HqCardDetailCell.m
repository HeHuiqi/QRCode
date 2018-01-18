//
//  HqCardDetailCell.m
//  QRCode
//
//  Created by macpro on 2018/1/18.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqCardDetailCell.h"

@implementation HqCardDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
