//
//  HqPickerView.m
//  iRAIDLoop
//
//  Created by macpro on 16/7/29.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import "HqPickerView.h"
@interface HqPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,strong) UIButton *confirmBtn;
@property (nonatomic,strong) UILabel *titleLab;


@property (nonatomic,strong) NSDateFormatter *timeformatter;

@property (nonnull,copy) NSString *selectedStr;

@end

@implementation HqPickerView

- (instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}
- (void)setup{

    self.backgroundColor = [COLOR(38, 38, 38, 1) colorWithAlphaComponent:0.9];
    self.alpha = 0.0;
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];

    
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [contentView addSubview:topView];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancelBtn.tintColor = AppMainColor;
    [_cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    _cancelBtn.tag = 1;
    [topView addSubview:_cancelBtn];
    
    _titleLab = [[UILabel alloc]init];
    _titleLab.font = [UIFont systemFontOfSize:14];
    _titleLab.text = self.title;
    [topView addSubview:_titleLab];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _confirmBtn.tintColor = AppMainColor;
    [_confirmBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"Done" forState:UIControlStateNormal];
    _confirmBtn.tag = 2;
    [topView addSubview:_confirmBtn];
    
    _datePickerView = [[UIDatePicker alloc]init];
    _datePickerView.datePickerMode = UIDatePickerModeDate;
    [contentView addSubview:_datePickerView];
    _datePickerView.hidden = YES;
    
    _pickerView = [[UIPickerView alloc]init];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [contentView addSubview:_pickerView];
    
    CGFloat topHeight  = 35;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.height.mas_equalTo(200);
    }];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(0);
        make.left.equalTo(contentView).offset(0);
        make.right.equalTo(contentView).offset(0);
        make.height.mas_equalTo(topHeight);
    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).offset(0);
        make.left.equalTo(topView).offset(0);
        make.size.mas_equalTo(CGSizeMake(60, topHeight));
    }];
    
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).offset(0);
        make.centerX.equalTo(topView.mas_centerX);
        make.height.mas_equalTo(topHeight);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).offset(0);
        make.right.equalTo(topView).offset(0);
        make.height.mas_equalTo(topHeight);
        make.size.mas_equalTo(CGSizeMake(60, topHeight));
    }];
    
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(0);
        make.centerX.equalTo(contentView.mas_centerX);
        make.width.mas_equalTo(100);

    }];
    
    [_datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(0);
        make.centerX.equalTo(contentView.mas_centerX);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];

}
- (void)setCancelTitle:(NSString *)cancelTitle{
    _cancelTitle = cancelTitle;
    if (_cancelTitle) {
        [_cancelBtn setTitle:_cancelTitle forState:UIControlStateNormal];
    }
}
- (void)setConfirmTitle:(NSString *)confirmTitle{
    _confirmTitle = confirmTitle;
    if (_confirmTitle) {
        [_confirmBtn setTitle:_confirmTitle forState:UIControlStateNormal];
    }
}
- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode{
    _datePickerMode = datePickerMode;
    _datePickerView.datePickerMode = _datePickerMode;
    switch (_datePickerMode) {
        case UIDatePickerModeDate:
        {
            [self.timeformatter setDateFormat:@"yyyy-MM-dd"];
            _datePickerView.minimumDate = [self.timeformatter dateFromString:@"1921-01-01"];
        }
            break;
        case UIDatePickerModeTime:
        {
            [self.timeformatter setDateFormat:@"HH:mm"];
        }
            break;
            
        default:
            break;
    }
}
- (void)btnClick:(UIButton *)btn{
    
    if (btn.tag == 2) {
        if (self.hqPickerViewBlock) {
            
            if (_isUseDate) {
                _selectedStr = [self.timeformatter stringFromDate:_datePickerView.date];
            }
            if (_isSetYearMonth) {
                NSString *str = [NSString stringWithFormat:@"%d-%02d",_year,_month];
                _selectedStr = str;
            }
            if (_selectedStr.length==0) {
                if (_pickerViewData.count>0) {
                    _selectedStr = _pickerViewData[0];
                }
            }
            self.hqPickerViewBlock(_selectedStr);
        }
    }
    if (self.superview) {
        [self removeFromSuperview];
    }
}

- (void)setTitle:(NSString *)title{
    _title = title;
    if (_title) {
        _titleLab.text = _title;
    }
}
- (void)setIsUseDate:(BOOL)isUseDate{
    _isUseDate = isUseDate;
    _datePickerView.hidden = !_isUseDate;
    if (_isUseDate) {
        _pickerView.hidden = YES;
    }
}
- (void)showPikerViewWithBlock:(HqPickerViewBlock)block
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(window).offset(0);
        make.left.equalTo(window).offset(0);
        make.right.equalTo(window).offset(0);
        make.bottom.equalTo(window).offset(0);
    }];
   
    self.hqPickerViewBlock = block;
}
- (void)setPickerViewSelectRow:(NSInteger)pickerViewSelectRow{
   
}
- (void)setSelectRow:(NSInteger)row component:(NSInteger)component{
    if (_pickerViewSelectRow<_pickerViewData.count) {
        _pickerViewSelectRow = row;
        _selectedStr = _pickerViewData[_pickerViewSelectRow];
        [self.pickerView selectRow:row inComponent:component animated:NO];
    }
}
- (void)setPickerViewData:(NSArray *)pickerViewData{
    _pickerViewData = pickerViewData;
    [_pickerView reloadAllComponents];
}
- (void)setMonthData:(NSArray *)monthData{
    _monthData = monthData;
    if (_monthData) {
        _month = [_monthData[6] intValue];
        [_pickerView reloadAllComponents];

    }
}
- (void)setYearData:(NSArray *)yearData{
    _yearData = yearData;
    if (_yearData) {
        NSInteger index = yearData.count/2;
        _year = [_yearData[index] intValue];
        
        [_pickerView reloadAllComponents];

    }
}
- (NSDateFormatter *)timeformatter{
    if (!_timeformatter) {
        _timeformatter = [[NSDateFormatter alloc]init];
        [_timeformatter setDateFormat:@"yyyy-MM-dd"];
    }
    return _timeformatter;
}
- (void)setIsSetYearMonth:(BOOL)isSetYearMonth{
    _isSetYearMonth = isSetYearMonth;
    if (_isSetYearMonth) {
        [_pickerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(250);
        }];
    }else{
        [_pickerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
        }];
    }
}
#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (_isSetYearMonth) {
        return 2;
    }
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (_isSetYearMonth) {
        if (component == 0) {
            return _yearData.count;
        }
        return _monthData.count;
    }else{
        return _pickerViewData.count;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (_isSetYearMonth) {
        
        if (component == 0) {
            
            int year = [_yearData[row] intValue];
            NSString *yearstr = [NSString stringWithFormat:@"%dYear",year];
            return yearstr;
        }
        int month = [_monthData[row] intValue];
        NSString *monthstr = [NSString stringWithFormat:@"%dMonth",month];
      
        return monthstr;
    }else{
        return  _pickerViewData[row];
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 35;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (_isSetYearMonth) {
        
        if (component == 0) {
            _year = [_yearData[row] intValue];

        }else{
            _month = [_monthData[row] intValue];
        }
        NSString *str = [NSString stringWithFormat:@"%d-%02d",_year,_month];
        _selectedStr = str;
        NSLog(@"str = %@",str);

    }else{
        _selectedStr = _pickerViewData[row];
    }
}
@end
