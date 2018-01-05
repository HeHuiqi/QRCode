//
//  ProjectEnvironment.h
//  iRAIDWear
//
//  Created by macpro on 2017/4/7.
//  Copyright © 2017年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG

#define SERVER      @"https://demo.tsp.eveus.com"

#elif Qa

#define SERVER      @"https://qawsm.xwf-id.com:4433"

#elif Pre

#define SERVER      @"https://prewsm.xwf-id.com"

#elif Prm

#define SERVER      @"https://prmwsm.xwf-id.com"

#elif Prd

#define SERVER      @"https://prdwsm.xwf-id.com"

#else

//prd
#define SERVER      @"https://prdwsm.xwf-id.com"

#endif

#define API_VERSION @"/api"
#define SERVSER_URL   [NSString stringWithFormat:@"%@%@",SERVER,API_VERSION]

@interface ProjectEnvironment : NSObject

@end
