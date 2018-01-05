//
//  HqCardsVC.m
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqCardsVC.h"
#import "HqCardCell.h"

@interface HqCardsVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HqCardsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Cards";
    [self initView];
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
//    footer.backgroundColor = [UIColor redColor];
    /*
     *画虚线
     */
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, kZoomValue(185)-40)];
    contentView.layer.cornerRadius = 2.0;
    CAShapeLayer *subLayer = [self dotteShapeLayer:contentView.bounds];
    [contentView.layer addSublayer:subLayer];
    
    /*
    CAShapeLayer *dotteShapeLayer = [CAShapeLayer layer];
    dotteShapeLayer.fillColor = [UIColor clearColor].CGColor;
    dotteShapeLayer.strokeColor = [UIColor grayColor].CGColor;
    dotteShapeLayer.lineWidth = LineHeight ;
    dotteShapeLayer.lineCap = kCALineCapRound;
    dotteShapeLayer.lineJoin = kCALineJoinRound;

    NSArray *lineDashPattern = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:3],[NSNumber numberWithInt:2], nil];
    dotteShapeLayer.lineDashPattern = lineDashPattern;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds cornerRadius:2.0];
    dotteShapeLayer.path = path.CGPath;
    [contentView.layer addSublayer:dotteShapeLayer];
    */
    
    return footer;
}
- (CAShapeLayer *)dotteShapeLayer:(CGRect)rect{
    
    /*
     *画虚线
     */
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, kZoomValue(185)-40)];
    contentView.layer.cornerRadius = 2.0;
    
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
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
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
    cell.bankNameLab.text = @"Bla Bank";
    cell.cardTypeLab.text = @"Debit Card";
    cell.cardNumberLab.text = @"1234 5678 8888 9890";
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
