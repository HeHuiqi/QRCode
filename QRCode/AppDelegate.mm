//
//  AppDelegate.m
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginVC.h"
#import "WecomeVC.h"
#import "HqRootVC.h"

#import "RegistVC.h"
#import <AssertMacros.h>
@interface AppDelegate ()

@end

@implementation AppDelegate
+ (void)setRootVC:(HqSetRootVC)type{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app _setRootVC:type];
}
- (void)_setRootVC:(HqSetRootVC)type{
    
    
    switch (type) {
            case HqSetRootVCLogin:{
            LoginVC *loginVC = [[LoginVC alloc] init];
            self.window.rootViewController = loginVC;
              ;
                
            }
            break;
            case HqSetRootVCWecome:{
                
                WecomeVC *welcomVC = [[WecomeVC alloc] init];
                 SuperNavigationVC *navRootVC = [[SuperNavigationVC alloc] initWithRootViewController:welcomVC];
                self.window.rootViewController = navRootVC;
                
//                RegistVC *loginVC = [[RegistVC alloc] init];
//                self.window.rootViewController = loginVC;
            }
            break;
            case HqSetRootVCHome:{
                HqRootVC *rootVC = [[HqRootVC alloc] init];
                SuperNavigationVC *navRootVC = [[SuperNavigationVC alloc] initWithRootViewController:rootVC];
                self.window.rootViewController = navRootVC;
            }
            break;
            
        default:
            break;
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
//    NSLog(@"ppppp= %@",[NSString sha1:@"aaa111"]);

    
    NSString *token = GetUserDefault(kToken);
    NSString *isLogin = GetUserDefault(kisLogin);
    if(token.length&&isLogin.boolValue){
        [AppDelegate setRootVC:HqSetRootVCHome];
    }else{
        [AppDelegate setRootVC:HqSetRootVCWecome];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

