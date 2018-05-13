//
//  AppDelegate.h
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

typedef NS_ENUM(NSUInteger, HqSetRootVC) {
    HqSetRootVCWecome,
    HqSetRootVCLogin,
    HqSetRootVCHome,
};

@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)shareApp;
+ (void)setRootVC:(HqSetRootVC)type;

@property (nonatomic,assign) BOOL isInputGesturePassword;
@property (nonatomic,assign) BOOL isPayer;


@end

