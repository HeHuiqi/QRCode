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
        UIButton *imageView = [UIButton buttonWithType:UIButtonTypeSystem];
        imageView.frame = CGRectMake(0, 0, kZoomValue(35), kZoomValue(20));
        imageView.tintColor = [UIColor blackColor];
        self.leftView = imageView;
        [imageView setImage:image forState:UIControlStateNormal];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode=  UITextFieldViewModeWhileEditing;
    }
    return self;
}

- (instancetype)initWithPlacehoder:(NSString *)placehoder{
    
    if(self = [super init]){
        self.backgroundColor = [UIColor whiteColor];
        self.placeholder = placehoder;
        UIView *imageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kZoomValue(10), kZoomValue(45))];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.leftView = imageView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode=  UITextFieldViewModeWhileEditing;
    }
    return self;
}

@end
