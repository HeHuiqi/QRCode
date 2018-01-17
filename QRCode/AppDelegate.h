//
//  AppDelegate.h
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HqSetRootVC) {
    HqSetRootVCWecome,
    HqSetRootVCLogin,
    HqSetRootVCHome,
};

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (void)setRootVC:(HqSetRootVC)type;

@end

