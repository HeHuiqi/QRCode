//
//  HqCustomButton.m
//  QRCode
//
//  Created by macpro on 2018/1/16.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqCustomButton.h"

@implementation HqCustomButton

- (void)setNormalTitle:(NSString *)normalTitle{
    _normalTitle = normalTitle;
    [self setTitle:_normalTitle forState:UIControlStateNormal];
}
- (void)setHighlightedTitle:(NSString *)highlightedTitle{
    
    _highlightedTitle = highlightedTitle;
    [self setTitle:_highlightedTitle forState:UIControlStateHighlighted];
}
- (void)setNormalImage:(UIImage *)normalImage{
    
    _normalImage = normalImage;
    [self setImage:_normalImage forState:UIControlStateNormal];
}

- (void)setHighlightedImage:(UIImage *)highlightedImage{
    _highlightedImage = highlightedImage;
    [self setImage:_highlightedImage forState:UIControlStateHighlighted];
}

- (void)setBgNormalImage:(UIImage *)bgNormalImage{
    _bgNormalImage = bgNormalImage;
    
    [self setBackgroundImage:_bgNormalImage forState:UIControlStateNormal];
}
- (void)setBgHighlightedImage:(UIImage *)bgHighlightedImage{
    _bgHighlightedImage = bgHighlightedImage;
    [self setBackgroundImage:_bgHighlightedImage forState:UIControlStateHighlighted];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
