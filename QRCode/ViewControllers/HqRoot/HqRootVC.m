//
//  ViewController.m
//  HqSlider
//
//  Created by hehuiqi on 2018/1/4.
//  Copyright © 2018年 hehuiqi. All rights reserved.
//

#import "HqRootVC.h"
#import "HqLeftView.h"

#define LeftWidth SCREEN_WIDTH - kZoomValue(100)
#define LeftAlpha 0.7
@interface HqRootVC ()<UITableViewDelegate,UITableViewDataSource,HqLeftViewDelegate>

@property (nonatomic,strong) HqLeftView *leftView;//左侧视图
@property (nonatomic,strong) UIView *mainOverView;//覆盖视图
@property (nonatomic,assign) BOOL isOpen;//左侧视图是否打开

@property (nonatomic,strong) UITableView *tableView;


@end

@implementation HqRootVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initData];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.mainOverView];
    [self.view addSubview:self.leftView];
    [self addGesture];
    
}
- (void)initData{
    self.isOpen = NO;
}
- (void)addGesture{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentfier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentfier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentfier];
    }
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

