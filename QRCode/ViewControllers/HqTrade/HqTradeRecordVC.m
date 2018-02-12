//
//  HqTradeRecordVC.m
//  QRCode
//
//  Created by macpro on 2018/1/19.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqTradeRecordVC.h"
#import "HqBillCell.h"
#import "HqNoContentView.h"
@interface HqTradeRecordVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *records;
@property (nonatomic,strong) HqNoContentView *noContentView;


@end

@implementation HqTradeRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Bill";
    _records = [[NSMutableArray alloc] init];
    [self getBillList];
    [self initView];
}
- (void)getBillList{
    [HqHttpUtil hqGetShowHudTitle:nil param:nil url:@"/transactions" complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"账单列表==%@",responseObject);
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                NSArray *orders = [responseObject hq_objectForKey:@"orders"];
                for (NSDictionary *dic in orders) {
                    HqBill *bill = [HqBill mj_objectWithKeyValues:dic];
                    [_records addObject:bill];
                }
                _noContentView.hidden = (orders.count>0);
                _tableView.hidden = (orders.count==0);
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
        [_tableView reloadData];
    }];
}
- (void)initView{
    self.isShowBottomLine = YES;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH  , SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.separatorColor = LineColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _noContentView = [[HqNoContentView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH  , SCREEN_HEIGHT-64)];
    _noContentView.centerIcon.image = [UIImage imageNamed:@""];
    _noContentView.infoLab.text = @"no transcation record";
    [self.view addSubview:_noContentView];
    _noContentView.hidden = YES;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _records.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kZoomValue(85)  ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentfier = @"HqBillCell";
    HqBillCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentfier];
    if (!cell) {
        cell = [[HqBillCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentfier];
    }
    
    HqBill *bill = _records[indexPath.row];
    cell.bill = bill;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
