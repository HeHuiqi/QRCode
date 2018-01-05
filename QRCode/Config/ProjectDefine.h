//
//  ProjectDefine.h
//  iRAIDLoop
//
//  Created by macpro on 16/7/12.
//  Copyright © 2016年 macpro. All rights reserved.
//

#ifndef ProjectDefine_h
#define ProjectDefine_h



#define SportMaxStep 10000.0




#define GetUserDefault(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

#define SetUserDefault(value,key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];


#define SetUserIntegerDefault(MyInteger,key)  [[NSUserDefaults standardUserDefaults] setInteger:MyInteger forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];
#define GetUserIntegerDefault(key)  [[NSUserDefaults standardUserDefaults] integerForKey:key]


#define SetUserBoolDefault(MyBool,key)  [[NSUserDefaults standardUserDefaults] setBool:MyBool forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];
#define GetUserBoolDefault(key) [[NSUserDefaults standardUserDefaults] boolForKey:key]

//#define BlueToothIsOpen()  [[CBCentralManager alloc]initWithDelegate:nil queue:nil]
#define BlueToothIsOpen()  [[CBCentralManager alloc]initWithDelegate:nil queue:nil options:@{CBCentralManagerOptionShowPowerAlertKey:[NSNumber numberWithBool:YES]}]

#define HqDINCond_BoldFontPath [[NSBundle mainBundle] pathForResource:@"DINCond-Bold" ofType:@"otf"]

#pragma mark -  颜色设置
#define COLORA(R, G, B)   [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]

#define COLOR(R, G, B, A)   [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define AppMainColor COLOR(59, 181, 247, 1)

#define AppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]
#define HqRedColor COLOR(248, 89, 76, 1)
#define HqGrayColor COLOR(212, 212, 212, 1)
#define HqGreenColor COLOR(18, 124, 3, 1)
#define HqDeepGrayColor COLOR(102, 102, 102, 1)
#define HqBlackColor COLOR(51, 51, 51, 1)



#define LineColor COLOR(229, 229, 229, 1)
#define LineHeight (1.0/[UIScreen mainScreen].scale)
#define AppLightColor [UIColor colorWithHex:0x999999]

//根据16进制颜色值得到颜色，eg:COLOR_RGB(0x666666,1)
#define COLOR_RGB(RGB, A)   [UIColor colorWithRed:(((RGB >> 16) & 0xff) / 255.0) green:(((RGB >> 8) & 0xff) / 255.0) blue:((RGB & 0xff) / 255.0) alpha:A]

#pragma mark -  函数宏
#define SetFont(size)  [UIFont systemFontOfSize:size]
#define SetFontDINCond(fsize) [UIFont customFontWithPath:HqDINCond_BoldFontPath size:fsize]

#define Alert(string)  [[[UIAlertView alloc] initWithTitle:nil message:string delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]

#define Push(VC)  VC.hidesBottomBarWhenPushed = YES;\
[self.navigationController pushViewController:VC animated:YES]

#define Present(VC) [self presentViewController:VC animated:YES completion:nil]

#define Dismiss() [self dismissViewControllerAnimated:YES completion:nil]

#define Back() [self.navigationController popViewControllerAnimated:YES]

#define BackRoot() [self.navigationController popToRootViewControllerAnimated:YES]

#pragma mark - UIKit
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width     //屏幕宽度

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height    //屏幕高度
#define kZoomScale (SCREEN_WIDTH/375.0)
//value是pt
#define kZoomValue(value) value*kZoomScale



//log--------
#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

//#define NSLog( s, ...) NSLog(@"\nfunction:%s,line:%d \n%@",__FUNCTION__,__LINE__,[NSString stringWithFormat:(s), ##__VA_ARGS__]);

#elif Qa
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

#elif Prd
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

#else
#define NSLog( s, ...);

#endif
//-------

#define weakly(target) __weak typeof(target) JC_WeakTarget = target;
#define strongly(target) __strong typeof(target) target = JC_WeakTarget;

/**
 *  支付方式
 */
typedef enum : NSUInteger {
    PayTypeWeiXin,
    PayTypeAliPay,
} PayType;

#endif


/* ProjectDefine_h */
