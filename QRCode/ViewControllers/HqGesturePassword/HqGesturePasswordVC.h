//
//  HqGesturePasswordVC.h
//  QRCode
//
//  Created by macpro on 2018/1/9.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "SuperVC.h"
typedef enum{
    GestureViewControllerTypeSetting = 1,
    GestureViewControllerTypeLogin
}GestureViewControllerType;

typedef enum{
    buttonTagReset = 1,
    buttonTagManager,
    buttonTagForget
    
}buttonTag;

@interface HqGesturePasswordVC : SuperVC

/**
 *  控制器来源类型
 */
@property (nonatomic, assign) GestureViewControllerType type;
@property (nonatomic,strong) HqUser *user;

@end
