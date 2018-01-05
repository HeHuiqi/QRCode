//
//  HqLeftView.m
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqLeftView.h"
#import "HqLeftViewCell.h"

@interface HqLeftView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *titles;

@end

@implementation HqLeftView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initData];
        [self initView];
    }
    return self;

}
- (void)initData{
    _titles = @[@{@"icon":@"",@"title":@"Home"},
                @{@"icon":@"",@"title":@"Settings"},
                @{@"icon":@"",@"title":@"Contacts"},
                @{@"icon":@"",@"title":@"Emergency"},
                @{@"icon":@"",@"title":@"About"}];
}
- (void)initView{
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-kZoomValue(60));
    _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    logoutBtn.tintColor = [UIColor whiteColor];
    [logoutBtn setTitle:@"Logout" forState:UIControlStateNormal];
    [self addSubview:logoutBtn];
    logoutBtn.backgroundColor = COLOR(17, 139, 226, 1);
    [logoutBtn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.height.mas_equalTo(kZoomValue(60));

    }];
    
}
- (void)logout:(UIButton *)btn{
    NSLog(@"logout");
//    SetUserDefault(nil, kToken);
//    [AppDelegate setRootVC:HqSetRootVCLogin];
}
#pragma UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentfier = @"HqLeftViewCell";
    HqLeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentfier];
    if (!cell) {
        cell = [[HqLeftViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentfier];
    }
    NSDictionary *titleDic = _titles[indexPath.row];
    cell.leftIcon.image = [UIImage imageNamed:titleDic[@"icon"]];
    cell.titleLab.text = titleDic[@"title"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.delegate){
        [self.delegate hqLeftView:self index:indexPath.row];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
