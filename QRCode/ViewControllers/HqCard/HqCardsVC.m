//
//  HqCardsVC.m
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqCardsVC.h"
#import "HqCardCell.h"
#import "HqUserIdInfoVC.h"

#import "HqPayPasswordVC.h"
#import "HqCardDetailVC.h"
#import "HqAddCardVC.h"
@interface HqCardsVC ()<UITableViewDelegate, UITableViewDataSource,HqCardDetailVCDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *cardList;

@property (nonatomic,strong) HqBankCard *curretnSelectedCard;//当前选中的银行卡进入详情页
@property (nonatomic,strong) HqBankCard *defaultCard;//默认卡
@end

@implementation HqCardsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Cards";
    _cardList = [[NSMutableArray alloc] init];
    [self initView];
    [self requsetCardList];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requsetCardList) name:kAddBankCardSuccess object:nil];
}
- (void)requsetCardList{
    NSDictionary *param = @{};
    [HqHttpUtil hqGetShowHudTitle:nil param:param url:@"/cards" complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"银行卡列表===%@",responseObject);
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                NSArray *cards = [responseObject hq_objectForKey:@"cards"];
                [_cardList removeAllObjects];
                for (NSDictionary *dic in cards) {
                    HqBankCard *card = [HqBankCard mj_objectWithKeyValues:dic];
                    if (card.isDefault) {
                        _defaultCard = card;
                    }
                    [_cardList addObject:card];
                }
                [_tableView reloadData];
                
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
}
- (void)initView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [self tableFooterView];
}
- (UIView *)tableFooterView{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kZoomValue(185))];
    /*
     *画虚线
     */
    UIButton *contentView = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, kZoomValue(185)-40)];
    [contentView addTarget:self action:@selector(addCards:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *linkCard = [UIImage imageNamed:@"cards_link"];
    contentView.layer.cornerRadius = kHqCornerRadius;
    [contentView setImage:linkCard forState:UIControlStateNormal];
    [footer addSubview:contentView];
    CAShapeLayer *subLayer = [self dotteShapeLayer:contentView.bounds];
    [contentView.layer addSublayer:subLayer];
    
    
    return footer;
}
- (CAShapeLayer *)dotteShapeLayer:(CGRect)rect{
    
    /*
     *画虚线
     */
//    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, kZoomValue(185)-40)];
//    contentView.layer.cornerRadius = 2.0;
    
    CAShapeLayer *dotteShapeLayer = [CAShapeLayer layer];
    dotteShapeLayer.fillColor = [UIColor clearColor].CGColor;
    dotteShapeLayer.strokeColor = [UIColor grayColor].CGColor;
    dotteShapeLayer.lineWidth = LineHeight ;
    dotteShapeLayer.lineCap = kCALineCapRound;
    dotteShapeLayer.lineJoin = kCALineJoinRound;
    
    NSArray *lineDashPattern = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:3],[NSNumber numberWithInt:2], nil];
    dotteShapeLayer.lineDashPattern = lineDashPattern;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:2.0];
    dotteShapeLayer.path = path.CGPath;
    
    return dotteShapeLayer;
}
#pragma mark - 添加银行卡
- (void)addCards:(UIButton *)btn{
    
    [self requestUerInfo];
}
#pragma mark - 获取用户信息
- (void)requestUerInfo{
    
    [HqHttpUtil hqGetShowHudTitle:nil param:nil url:@"/users"   complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        if (response.statusCode == 200) {
            NSLog(@"用户信息==%@",responseObject);
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                
                HqUser *user = [HqUser mj_objectWithKeyValues:responseObject];
                
                if (_cardList.count==0) {
                    if (user.idNumber.length>0&&user.realName.length>0) {
                        if (user.hasPin) {
                            HqPayPasswordVC *passwordVC = [[HqPayPasswordVC alloc] init];
                            passwordVC.user = user;
                            passwordVC.isFromAddCardInfo = 0;
                            passwordVC.payPasswordType = HqPayPasswordInput;
                            Push(passwordVC);
                        }else{
                            HqAddCardVC *addCardVC = [[HqAddCardVC alloc] init];
                            addCardVC.user = user;
                            Push(addCardVC);
                        }
                    }else{
                        HqUserIdInfoVC *idUserVC = [[HqUserIdInfoVC alloc] init];
                        Push(idUserVC);
                    }
                }else{
                    HqPayPasswordVC *passwordVC = [[HqPayPasswordVC alloc] init];
                    passwordVC.user = user;
                    if (user.hasPin) {
                        passwordVC.payPasswordType = HqPayPasswordInput;
                        passwordVC.isFromAddCardInfo = 0;
                    }else{
                        passwordVC.payPasswordType = HqPayPasswordCreate;
                        passwordVC.isFromAddCardInfo = 0;
                    }
                    Push(passwordVC);
                }
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cardList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kZoomValue(185);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentfier = @"HqCardCell";
    HqCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentfier];
    if (!cell) {
        cell = [[HqCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentfier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HqBankCard *card = _cardList[indexPath.row];
    cell.bankCard = card;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HqCardDetailVC *cardDetailVC = [[HqCardDetailVC alloc] init];
    _curretnSelectedCard = _cardList[indexPath.row];
    cardDetailVC.delegate = self;
    cardDetailVC.bankCard = _curretnSelectedCard;
    Push(cardDetailVC);
}
#pragma mark - HqCardDetailVCDelegate
- (void)hqCardDetailVC:(HqCardDetailVC *)vc cardOperate:(HqCardOperate)operate{
    switch (operate) {
        case HqCardOperateDelete:
            {
                if (_curretnSelectedCard) {
                    [_cardList removeObject:_curretnSelectedCard];
                }
            }
            break;
        case HqCardOperateSetDetault:
        {
            _curretnSelectedCard.isDefault = YES;
            _defaultCard.isDefault = NO;
            _defaultCard = _curretnSelectedCard;
        }
            break;
    }
    [_tableView reloadData];
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
