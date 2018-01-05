//
//  HqInputView.m
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqInputView.h"

@implementation HqInputView

- (instancetype)initWithPlacehoder:(NSString *)placehoder leftIcon:(NSString *)leftIcon{
    
    if(self = [super init]){
        self.backgroundColor = [UIColor whiteColor];
        self.placeholder = placehoder;
        UIImage *image = [UIImage imageNamed:leftIcon];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kZoomValue(30), kZoomValue(45))];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor redColor];
        imageView.image = image;
        self.leftView = imageView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode=  UITextFieldViewModeWhileEditing;
    }
    return self;
}

@end
