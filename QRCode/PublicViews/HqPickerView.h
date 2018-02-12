//
//  HqPickerView.h
//  iRAIDLoop
//
//  Created by macpro on 16/7/29.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void  (^HqPickerViewBlock)(NSString *text);
@interface HqPickerView : UIView

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *cancelTitle;
@property (nonatomic,copy) NSString *confirmTitle;
@property (nonatomic,strong) NSArray *pickerViewData;//数据

@property (nonatomic,strong) UIPickerView *pickerView;
@property (nonatomic,strong) UIDatePicker *datePickerView;
@property (nonatomic,assign) UIDatePickerMode datePickerMode;
@property (nonatomic,assign) NSInteger pickerViewSelectRow;

//使用系统DatePicker
@property (nonatomic,copy) HqPickerViewBlock hqPickerViewBlock;
@property (nonatomic,assign) BOOL isUseDate;

//自定义年月
@property (nonatomic,strong) NSArray *monthData;
@property (nonatomic,strong) NSArray *yearData;
@property (nonatomic,assign) int year;
@property (nonatomic,assign) int month;

@property (nonatomic,assign) BOOL isSetYearMonth;


- (void)showPikerViewWithBlock:(HqPickerViewBlock)block;

//设置默认选中行
- (void)setSelectRow:(NSInteger)row component:(NSInteger)component;

@end
