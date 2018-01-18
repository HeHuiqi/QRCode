//
//  HqLeftView.m
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqLeftView.h"
#import "HqLeftViewCell.h"
#define HqCellHeight 50
@interface HqLeftView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *titles;

@end

@implementation HqLeftView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self initData];
        [self initView];
    }
    return self;

}
- (void)initData{
    _titles = @[@{@"icon":@"home_icon",@"title":@"Home"},
                @{@"icon":@"",@"title":@"Settings"},
                @{@"icon":@"bill_icon",@"title":@"Contacts"},
                @{@"icon":@"emergency_icon",@"title":@"Emergency"},
                @{@"icon":@"about_icon",@"title":@"About"}];
}
- (void)initView{
    UIView *topBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 64)];
    topBarView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:topBarView];
    CGFloat headerHeight = kZoomValue(120);
    CGFloat tableHeight =  self.bounds.size.height-64-kZoomValue(55)-headerHeight;
    CGRect rect = CGRectMake(0,headerHeight+64, self.bounds.size.width, tableHeight);
    _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        make.height.mas_equalTo(kZoomValue(55));

    }];
    
}
#pragma mark - 退出登录
- (void)logout:(UIButton *)btn{
    NSLog(@"logout");
    [HqHttpUtil hqDeleteShowHudTitle:nil param:nil url:@"/users/sessions" complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                SetUserDefault(nil, kToken);
                SetUserDefault(nil, kisLogin);
                [AppDelegate setRootVC:HqSetRootVCLogin];
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];

}
#pragma UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kZoomValue(HqCellHeight);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentfier = @"HqLeftViewCell";
    HqLeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentfier];
    if (!cell) {
        cell = [[HqLeftViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentfier];
    }
    NSDictionary *titleDic = _titles[indexPath.row];
    UIImage *image =  [UIImage imageNamed:titleDic[@"icon"]];
    [cell.leftIcon setImage:image forState:UIControlStateNormal];
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
