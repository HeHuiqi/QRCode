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
                @{@"icon":@"home_set_icon",@"title":@"Settings"},
                @{@"icon":@"bill_icon",@"title":@"Bill"},
                @{@"icon":@"emergency_icon",@"title":@"Emergency"},
                @{@"icon":@"about_icon",@"title":@"About"}];
}
- (void)backClick{
    if(self.delegate){
        [self.delegate hqLeftView:self index:100];
    }
}
- (UILabel *)titelLab{
    UILabel * leftTitle = [[UILabel alloc]init];
    leftTitle.textColor = COLORA(69, 90, 100);
    leftTitle.font = [UIFont boldSystemFontOfSize:kZoomValue(18)];
    return leftTitle;
}
- (void)initView{
    
    BOOL device = IS_NOT_IPHONE_X;
    CGFloat barHeight = 64;
    if (!device) {
        barHeight = 88;
    }
    UIView *topBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, barHeight)];
    topBarView.backgroundColor = COLOR(241,245,247,1);
    [self addSubview:topBarView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];;
    backBtn.tintColor = COLOR(102, 102, 102, 1);
    UIImage *image = [UIImage imageNamed:@"back"];
    [backBtn setImage:image forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [topBarView addSubview:backBtn];
//    [backBtn setTitle:@"Menu" forState:UIControlStateNormal];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topBarView).offset(0);
        make.bottom.equalTo(topBarView).offset(0);
        make.size.mas_equalTo(CGSizeMake(50, 44));
    }];
    
    UILabel *leftTitle = [self titelLab];
    leftTitle.text = @"Menu";
    [topBarView addSubview:leftTitle];
    [leftTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(topBarView.mas_centerX);
        make.left.equalTo(topBarView).offset(kZoomValue(50));
        make.bottom.equalTo(topBarView).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    CGFloat headerHeight = kZoomValue(120);
    CGFloat tableHeight =  self.bounds.size.height-barHeight-kZoomValue(55)-headerHeight;
    CGRect rect = CGRectMake(0,headerHeight+barHeight, self.bounds.size.width, tableHeight);
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
    if(self.delegate){
        [self.delegate hqLeftView:self index:100];
    }
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
