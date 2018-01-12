//
//  ViewController.m
//  HqSlider
//
//  Created by hehuiqi on 2018/1/4.
//  Copyright © 2018年 hehuiqi. All rights reserved.
//

#import "HqRootVC.h"
#import "HqLeftView.h"
#import "HqButton.h"
#import "HqHomeCell.h"
#import "HqScanPayVC.h"
#import "HqCardsVC.h"

#import "HqGesturePasswordVC.h"

#define LeftWidth (SCREEN_WIDTH - kZoomValue(52))
#define LeftAlpha 0.7
@interface HqRootVC ()<UITableViewDelegate,UITableViewDataSource,HqLeftViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) HqLeftView *leftView;//左侧视图
@property (nonatomic,strong) UIView *mainOverView;//覆盖视图
@property (nonatomic,assign) BOOL isOpen;//左侧视图是否打开
@property (nonatomic,strong) UIImageView *tableHeaderView;

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HqRootVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    self.title = @"Home";
    self.leftBtnImageName = @"home_menu_icon";
    [self headerView];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.tableHeaderView;
    
    [self.view addSubview:self.mainOverView];
    [self.view addSubview:self.leftView];
    [self addGesture];
    
    NSString *token = GetUserDefault(kToken);
    NSLog(@"token==%@",token);
}
- (void)initData{
    self.isOpen = NO;
}
- (void)headerView{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, kZoomValue(70))];
    header.backgroundColor = AppMainColor;
    NSArray *titles = @[@"Scan",@"Collect",@"Pay",@"Cards"];
    NSArray *images = @[@"home_scan_icon",@"",@"home_pay_icon",@"home_cards_icon"];
    for (int i = 0; i<titles.count; i++) {
        CGFloat width = SCREEN_WIDTH/titles.count;
        HqButton *button = [[HqButton alloc] initWithFrame:CGRectMake(i*width, 0, width, kZoomValue(70))];
        button.iconImage = [UIImage imageNamed:images[i]];
        button.title = titles[i];
        [button addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+1;
        [header addSubview:button];
    }
    [self.view addSubview:header];
}
#pragma mark - 头部点击事件
- (void)headerClick:(HqButton *)btn{
    NSLog(@"btn= %@",@(btn.tag));
    switch (btn.tag) {
            case 1:
            {
                HqScanPayVC *scanVC = [[HqScanPayVC alloc] init];
                Push(scanVC);
            }
            break;
            case 2:
            {
//                [Dialog simpleToast:@"This feature is not complete yet"];
                HqGesturePasswordVC *gesturePasswordVC = [[HqGesturePasswordVC alloc] init];
                gesturePasswordVC.type = GestureViewControllerTypeLogin;
                Push(gesturePasswordVC);
            }
            break;
            case 4:
            {
                HqCardsVC *cardsVC = [[HqCardsVC alloc] init];
                Push(cardsVC);
            }
            break;
            
        default:
            break;
    }
}
- (void)addGesture{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    UITapGestureRecognizer *overTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOver:)];
    [self.mainOverView addGestureRecognizer:overTap];
}
- (void)tapOver:(UITapGestureRecognizer *)tap{
    [self closeLeftView];
}
- (void)closeLeftView{
    [UIView animateWithDuration:0.1 animations:^{
        self.leftView.frame = CGRectMake(-LeftWidth, 0, LeftWidth, self.view.bounds.size.height);
        self.mainOverView.alpha = 0.0;
        self.isOpen = NO;
    }];
}
- (void)openLeftView{
    [UIView animateWithDuration:0.1 animations:^{
        self.leftView.frame = CGRectMake(0, 0, LeftWidth, self.view.frame.size.height);
        self.mainOverView.alpha = LeftAlpha;
        self.isOpen = YES;
    }];
}
#pragma mark -  处理Pan手势
- (void)panView:(UIPanGestureRecognizer *)panGesture{
    
    CGPoint point = [panGesture translationInView:self.view];
    CGFloat xOffset = point.x;
    //    NSLog(@"xOffset==%f",xOffset);
    
    if(!self.isOpen&&xOffset<0){
        return;
    }
    
    switch (panGesture.state) {
            case UIGestureRecognizerStateBegan:
            
            break;
            case UIGestureRecognizerStateChanged:
        {
            
            if (xOffset>=LeftWidth) {
                return;
            }
            
            if (xOffset>0&&self.leftView.frame.origin.x==0) {
                return;
            }
            if (xOffset<0&&self.leftView.frame.origin.x==LeftWidth) {
                return;
            }
            if (xOffset<0&&self.leftView.frame.origin.x<=0) {
                self.leftView.frame = CGRectMake(xOffset, 0, LeftWidth, self.view.frame.size.height);
            }else{
                self.leftView.frame = CGRectMake(floor(xOffset)-LeftWidth, 0, LeftWidth, self.view.frame.size.height);
            }
            self.mainOverView.alpha = fabs(xOffset)/LeftWidth/2.0;
        }
            
            break;
            case UIGestureRecognizerStateEnded:{
                self.view.userInteractionEnabled = YES;
                
                [UIView animateWithDuration:0.1 animations:^{
                    if (self.leftView.frame.origin.x>-LeftWidth/2.0) {
                        self.leftView.frame = CGRectMake(0, 0, LeftWidth, self.view.frame.size.height);
                        self.mainOverView.alpha = LeftAlpha;
                        self.isOpen = YES;
                    }else{
                        self.leftView.frame = CGRectMake(-LeftWidth, 0, LeftWidth, self.view.frame.size.height);
                        self.mainOverView.alpha = 0.0;
                        self.isOpen = NO;
                    }
                }];
                
            }
            break;
            
        default:
            break;
    }
    
    
}
- (UIImageView *)tableHeaderView{
    if(!_tableHeaderView){
        _tableHeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    }
    return _tableHeaderView;
}
- (HqLeftView *)leftView{
    if (!_leftView) {
        _leftView = [[HqLeftView alloc] initWithFrame:CGRectMake(-LeftWidth, 0, LeftWidth, self.view.bounds.size.height)];
        _leftView.delegate = self;
    }
    return _leftView;
}
- (UIView *)mainOverView{
    
    if (!_mainOverView) {
        _mainOverView = [[UIView alloc] initWithFrame:self.view.frame];
        _mainOverView.backgroundColor = [UIColor whiteColor];
        _mainOverView.alpha = 0.0;
    }
    return _mainOverView;
}
- (UITableView *)tableView{
    if(!_tableView){
        CGFloat  y = kZoomValue(70)+64;
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height-y) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kZoomValue(137);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentfier = @"HqHomeCell";
    HqHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentfier];
    if (!cell) {
        cell = [[HqHomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentfier];
    }
    cell.titleLab.text = @"Main Bank";
    cell.dateLab.text  = @"September, 19";
    cell.contentLab.text = @"Cras quis nulla commodo, aliquam lectus sed, blandit augue. Cra";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
- (void)backClick{
    
    [self openLeftView];
    
}

#pragma mark - HqLeftViewDelegate
- (void)hqLeftView:(HqLeftView *)view index:(NSInteger)index{
    [self closeLeftView];
    
    NSLog(@"index==%@",@(index));
    
    switch (index) {
            case 0:
        {
            
        }
            break;
            case 1:
        {
            
        }
            break;
            case 2:
        {
            
        }
            break;
            case 3:
        {
            
        }
            break;
            case 4:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    BOOL isHqButton = [touch.view isKindOfClass: NSClassFromString(@"HqButton")];
    if(isHqButton) {
        return NO;
    }
    return  YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

