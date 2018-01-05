//
//  NSDictionary+isNULL.m
//  XWF_iOS
//
//  Created by iMac on 15/5/28.
//  Copyright (c) 2015年 xwf_id. All rights reserved.
//

#import "NSDictionary+isNULL.h"

@implementation NSDictionary (isNULL)

- (id) hq_objectForKey: (NSString *) key
{
    id obj = [self objectForKey: key];
   
    if ([obj isKindOfClass: [NSNull class]])
    {
        return nil;
    }
    return obj;
}

@end
