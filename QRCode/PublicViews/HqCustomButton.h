//
//  HqCustomButton.h
//  QRCode
//
//  Created by macpro on 2018/1/16.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HqCustomButton : UIButton

@property (nonatomic,copy) NSString *normalTitle;
@property (nonatomic,copy) NSString *highlightedTitle;


@property (nonatomic,strong) UIImage *normalImage;
@property (nonatomic,strong) UIImage *highlightedImage;

@property (nonatomic,strong) UIImage *bgHighlightedImage;
@property (nonatomic,strong) UIImage *bgNormalImage;

@end
