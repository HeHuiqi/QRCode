//
//  ProjectEnvironment.h
//  iRAIDWear
//
//  Created by macpro on 2017/4/7.
//  Copyright © 2017年 macpro. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG

#define HTML_URL    @"https://qiniu-wsm-dev.xwf-id.com"
#define SERVER      @"https://devwsm.xwf-id.com"

#elif Qa

#define SERVER      @"https://qawsm.xwf-id.com:4433"
#define HTML_URL    @"https://qiniu-wsm-dev.xwf-id.com:4433"

#elif Pre

#define SERVER      @"https://prewsm.xwf-id.com"
#define HTML_URL    @"https://qiniu-wsm-dev.xwf-id.com"

#elif Prm

#define SERVER      @"https://prmwsm.xwf-id.com"
#define HTML_URL    @"https://qiniu-wsm-prm.xwf-id.com"

#elif Prd

#define SERVER      @"https://prdwsm.xwf-id.com"
#define HTML_URL    @"https://qiniu-wsm-prd.xwf-id.com"

#else

//prd
#define SERVER      @"https://prdwsm.xwf-id.com"
#define HTML_URL    @"https://qiniu-wsm-prd.xwf-id.com"

#endif

#define API_VERSION @"/api/v1.0"
#define SERVSER_URL   [NSString stringWithFormat:@"%@%@",SERVER,API_VERSION]

@interface ProjectEnvironment : NSObject

@end
