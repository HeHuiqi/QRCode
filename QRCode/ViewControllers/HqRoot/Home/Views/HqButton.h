//
//  HqButton.h
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HqButton : UIControl

@property (nonatomic,strong) UIImage *iconImage;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) BOOL isSetHighlighted;
@property (nonatomic,assign) CGSize iconSize;

@end
