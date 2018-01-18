//
//  HqCardDetailVC.m
//  QRCode
//
//  Created by macpro on 2018/1/16.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqCardDetailVC.h"
#import "HqCardCell.h"
#import "HqCardDetailCell.h"
@interface HqCardDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HqCardDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Card Detail";
    [self initView];
    
}

- (void)initView{
    self.isShowBottomLine = YES;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navBarView.frame),SCREEN_WIDTH , SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.separatorColor = LineColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return kZoomValue(185);
    }
    return kZoomValue(50);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *cellIndentfier = @"HqCardCell";
        HqCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentfier];
        if (!cell) {
            cell = [[HqCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentfier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.bankCard = _bankCard;
        
        return cell;
    }else{
        static NSString *cellIndentfier = @"HqCardDetailCell";
        HqCardDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentfier];
        if (!cell) {
            cell = [[HqCardDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentfier];
        }
        if (indexPath.row==1) {
            cell.accessoryView = [self chooseSwitch];
            
            cell.textLabel.text = @"Set Default Card";
        }else{
            cell.accessoryView = nil;
            cell.textLabel.text = @"Delate Card";
        }
        return cell;
    }

}
- (UISwitch *)chooseSwitch{

    UISwitch *hqSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [hqSwitch addTarget:self action:@selector(hqSetDefaultCard:) forControlEvents:UIControlEventValueChanged];
    if (_bankCard.isDefault) {
        hqSwitch.enabled = NO;
    }
    hqSwitch.on = _bankCard.isDefault;
    return hqSwitch;
}
- (void)hqSetDefaultCard:(UISwitch *)hqSwitch{
    
    [self setDefaultCard];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        if (_bankCard.isDefault) {
            [Dialog simpleToast:@"The default card can't be removed"];
            return;
        }
        [self deleteCard];
    }
}

#pragma mark - 设置默认卡
- (void)setDefaultCard{
    
    NSString *url = [NSString stringWithFormat:@"/cards/%@/default",_bankCard.cardNumber];
    NSDictionary *param = @{};
    [HqHttpUtil hqPutShowHudTitle:nil param:param url:url   complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        if (response.statusCode == 200) {
            NSLog(@"设置默认卡==%@",responseObject);
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                if (self.delegate) {
                    [self.delegate hqCardDetailVC:self cardOperate:HqCardOperateSetDetault];
                }
                [Dialog simpleToast:@"Operate Success!"];
                [self backClick];

            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
}
#pragma mark - 删除卡
- (void)deleteCard{
    NSString *url = [NSString stringWithFormat:@"/cards/%@",_bankCard.cardNumber];
    NSDictionary *param = @{};
    [HqHttpUtil hqDeleteShowHudTitle:nil param:param url:url   complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        if (response.statusCode == 200) {
            NSLog(@"删除卡==%@",responseObject);
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                if (self.delegate) {
                    [self.delegate hqCardDetailVC:self cardOperate:HqCardOperateDelete];
                }
                [Dialog simpleToast:@"Delete Success!"];
                [self backClick];
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
