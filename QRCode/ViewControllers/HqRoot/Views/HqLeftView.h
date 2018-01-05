//
//  HqLeftView.h
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HqLeftViewDelegate;

@interface HqLeftView : UIView

@property (nonatomic,assign) id<HqLeftViewDelegate> delegate;

@end

@protocol HqLeftViewDelegate

@optional
- (void)hqLeftView:(HqLeftView *)view index:(NSInteger)index;

@end
