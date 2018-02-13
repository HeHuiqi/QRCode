//
//  HqTransferView.h
//  QRCode
//
//  Created by macpro on 2018/2/11.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HqTransferView : UIView

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *titleIconName;
@property (nonatomic,strong) NSString *subCenterTitle;

@property (nonatomic,assign) CGFloat money;

@property (nonatomic,strong) NSDictionary *params;


- (void)startGetPayCode;
- (void)stopGetPayCode;


@end
