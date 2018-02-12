//
//  HqGesturePasswordVC.m
//  QRCode
//
//  Created by macpro on 2018/1/9.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqGesturePasswordVC.h"
#import "PCCircleView.h"
#import "PCCircleViewConst.h"
#import "PCCircleView.h"
#import "PCCircleViewConst.h"
#import "PCLockLabel.h"
#import "PCCircleInfoView.h"
#import "PCCircle.h"

//set
#define HqSetDrawPassword @"Set a pattern password"
#define HqDrawAgain @"Enter again Confirm"
#define HqDrawAgainWrong @"Inconsistent with the previous drawing, please redraw"
#define HqDrawLest [NSString stringWithFormat:@"Connect at least %d points, please re-enter", CircleSetCountLeast]

//login
#define HqInputDrawPassword @"Enter Password!"
#define HqInputDrawPasswordSuccess @"Successful!"
#define HqInputDrawPasswordWrong @"Wrong!"



@interface HqGesturePasswordVC ()<CircleViewDelegate,UINavigationControllerDelegate>

/**
 *  提示Label
 */
@property (nonatomic, strong) PCLockLabel *msgLabel;

/**
 *  解锁界面
 */
@property (nonatomic, strong) PCCircleView *lockView;

/**
 *  infoView
 */
@property (nonatomic, strong) PCCircleInfoView *infoView;

@end

@implementation HqGesturePasswordVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 进来先清空存的第一个密码
    [PCCircleViewConst saveGesture:nil Key:gestureOneSaveKey];
//    NSString *passss = [PCCircleViewConst getGestureWithKey:gestureFinalSaveKey];
//    NSLog(@"pppppp===%@",passss);
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationController.delegate = self;
    
    // 1.界面相同部分生成器
    [self setupSameUI];
    
    // 2.界面不同部分生成器
    [self setupDifferentUI];
}

#pragma mark - 界面不同部分生成器
- (void)setupDifferentUI
{
    switch (self.type) {
        case GestureViewControllerTypeSetting:
            [self setupSubViewsSettingVc];
            break;
        case GestureViewControllerTypeLogin:
            [self setupSubViewsLoginVc];
            break;
        default:
            break;
    }
}

#pragma mark - 界面相同部分生成器
- (void)setupSameUI
{
    self.title = @"Pattern Password";

    // 解锁界面
    PCCircleView *lockView = [[PCCircleView alloc] init];
    lockView.delegate = self;
    self.lockView = lockView;
    [self.view addSubview:lockView];
    
    PCLockLabel *msgLabel = [[PCLockLabel alloc] init];
    msgLabel.bounds = CGRectMake(0, 0, kScreenW, kZoomValue(20));
    msgLabel.center = CGPointMake(kScreenW/2, CGRectGetMinY(lockView.frame) - 30);
    self.msgLabel = msgLabel;
    [self.view addSubview:msgLabel];
    
    PCCircleInfoView *infoView = [[PCCircleInfoView alloc] init];
    infoView.frame = CGRectMake(0, 0, CircleRadius * 2, CircleRadius * 2);
    infoView.center = CGPointMake(kScreenW/2, CGRectGetMinY(self.msgLabel.frame) - CGRectGetHeight(infoView.frame)/2 - 14);
    self.infoView = infoView;
    [self.view addSubview:infoView];
}

#pragma mark - 设置手势密码界面
- (void)setupSubViewsSettingVc
{
    [self.lockView setType:CircleViewTypeSetting];
    [self.msgLabel showNormalMsg:HqSetDrawPassword];
}
#pragma mark - 登陆手势密码界面
- (void)setupSubViewsLoginVc
{
    [self.lockView setType:CircleViewTypeLogin];
    [self.msgLabel showNormalMsg:HqInputDrawPassword];
}
#pragma mark - 重设密码
/*
- (void)didClickRightItem {
    NSLog(@"点击了重设按钮");
    // 1.隐藏按钮
    self.navigationItem.rightBarButtonItem.title = nil;
    
    // 2.infoView取消选中
    [self infoViewDeselectedSubviews];
    
    // 3.msgLabel提示文字复位
    [self.msgLabel showNormalMsg:HqSetDrawPassword];
    
    // 4.清除之前存储的密码
    [PCCircleViewConst saveGesture:nil Key:gestureOneSaveKey];
    [PCCircleViewConst saveGesture:nil Key:gestureFinalSaveKey];

}
*/

#pragma mark - circleView - delegate
#pragma mark - circleView - delegate - setting
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type connectCirclesLessThanNeedWithGesture:(NSString *)gesture
{
    NSString *gestureOne = [PCCircleViewConst getGestureWithKey:gestureOneSaveKey];

    // 看是否存在第一个密码
    if ([gestureOne length]) {
        [self.msgLabel showWarnMsgAndShake:HqDrawAgainWrong];
    } else {
        NSLog(@"密码长度不合法%@", gesture);
        [self.msgLabel showWarnMsgAndShake:HqDrawLest];
    }
}

- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteSetFirstGesture:(NSString *)gesture
{
    NSLog(@"获得第一个手势密码%@", gesture);
    [self.msgLabel showWarnMsg:HqDrawAgain];
    
    // infoView展示对应选中的圆
    [self infoViewSelectedSubviewsSameAsCircleView:view];
}

- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteSetSecondGesture:(NSString *)gesture result:(BOOL)equal
{
    NSLog(@"获得第二个手势密码%@",gesture);
    
    if (equal) {
        
        NSLog(@"两次手势匹配！可以进行本地化保存了");
        
        [self.msgLabel showWarnMsg:HqInputDrawPasswordSuccess];
        [PCCircleViewConst saveGesture:gesture Key:gestureFinalSaveKey];
         [self uploadGesturePassword:gesture];
        
    } else {
        NSLog(@"两次手势不匹配！");
        [self.msgLabel showWarnMsgAndShake:HqDrawAgainWrong];
    }
}

#pragma mark - circleView - delegate - login or verify gesture
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal
{
    [self infoViewSelectedSubviewsSameAsCircleView:view];

    // 此时的type有两种情况 Login or verify
    if (type == CircleViewTypeLogin) {
        if (gesture.length<4) {
            NSLog(@"密码长度不合法%@", gesture);
            [self.msgLabel showWarnMsgAndShake:HqDrawLest];
            return;
        }
        //注意CircleViewTypeLogin此时始终相等，任意输入，去服务器验证,PCCircleView中
        //equal始终为YES
        if (equal) {
            [self uploadGesturePassword:gesture];
        } else {
            NSLog(@"密码错误！");
            [self.msgLabel showWarnMsgAndShake:HqInputDrawPasswordWrong];
        }
    } else if (type == CircleViewTypeVerify) {
        
        if (equal) {
            NSLog(@"验证成功，跳转到设置手势界面");
            
        } else {
            NSLog(@"原手势密码输入错误！");
        }
    }
}

#pragma mark - infoView展示方法
#pragma mark - 让infoView对应按钮选中
- (void)infoViewSelectedSubviewsSameAsCircleView:(PCCircleView *)circleView {
    //先取消
    [self infoViewDeselectedSubviews];
    //在设置
    for (PCCircle *circle in circleView.subviews) {
        
        if (circle.state == CircleStateSelected || circle.state == CircleStateLastOneSelected) {
            
            for (PCCircle *infoCircle in self.infoView.subviews) {
                if (infoCircle.tag == circle.tag) {
                    NSLog(@"iiii--%@",@(infoCircle.tag));

                    [infoCircle setState:CircleStateSelected];
                }
            }
        }
    }
}

#pragma mark - 让infoView对应按钮取消选中

- (void)infoViewDeselectedSubviews {
    [self.infoView.subviews enumerateObjectsUsingBlock:^(PCCircle *obj, NSUInteger idx, BOOL *stop) {
        [obj setState:CircleStateNormal];
    }];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isLoginType = [viewController isKindOfClass:[self class]];
    
    if (self.type == GestureViewControllerTypeLogin) {
//        [self.navigationController setNavigationBarHidden:isLoginType animated:YES];
        self.navBarView.hidden = isLoginType;
    }
}
#pragma mark - 上传手势密码
- (void)uploadGesturePassword:(NSString *)password{
    NSLog(@"gesture--password == %@",password);
    password = [NSString stringWithFormat:@"null%@",password];
    password = [NSString sha1:password];
//    return;
    NSDictionary *param = @{@"gesture": password};
    
    NSString *url = @"/users/gestures/checking";
    if (_type == GestureViewControllerTypeSetting) {
        url = @"/users/gestures";
    }
    [HqHttpUtil hqPostShowHudTitle:nil param:param url:url complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"手势密码==%@",responseObject);
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                [self.msgLabel showWarnMsg:HqInputDrawPasswordSuccess];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [Dialog simpleToast:msg];

                int remainRetries = [[responseObject hq_objectForKey:@"remainRetries"] intValue];
                if (remainRetries == 0) {
                    SetUserDefault(nil, kToken);
                    SetUserDefault(nil, kisLogin)
                    [AppDelegate setRootVC:HqSetRootVCLogin];
                }

            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
