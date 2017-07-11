//
//  HLHomeViewController.m
//  HellowWeather
//
//  Created by Pisces on 2017/6/30.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLHomeViewController.h"
#import "HLWeatherModel.h"
#import <MJExtension.h>
#import "HLTopView.h"
#import "UINavigationBar+Awesome.h"
#import "HLBottomViewController.h"
#import "HLPresentAnimator.h"
#import "HLDismissAnimator.h"
#import "HLDetailViewController.h"
#import "HLPhotosViewController.h"
#import "HLCalendarViewController.h"
@interface HLHomeViewController ()<HLTopViewDelegate,UIScrollViewDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *futureDataArray;

@property (nonatomic, strong) HLTopView *topView;

@property (nonatomic, strong) HLBottomViewController *bottomVC;

@property (strong, nonatomic) HLCalendarViewController *calendarVC;

@property (nonatomic, strong) NSString *cityName;

@property (nonatomic, strong) NSString *provinceName;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIImageView *dragView;

@property (assign, nonatomic) BOOL isShowCalendar;


@end

@implementation HLHomeViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    // 设置一个空的 shadowImage 来实现
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    

    //根据城市名称加载
    [self loadNewDataWithCity:@"广州" andProvince:@"广东省"];
    self.topView.stautsLabel.JYD_Height = 13;
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isShowCalendar = NO;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupViews];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(listBarClick)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClickShow)];
    [self.navigationController.navigationBar addGestureRecognizer:tap];
    
}

- (void)titleClickShow {
    self.isShowCalendar = !self.isShowCalendar;
    
    
    
    if (self.isShowCalendar) {
        HLCalendarViewController *vc = [[HLCalendarViewController alloc] init];
        vc.view.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), SSScreenW, 0);
        vc.view.backgroundColor = [UIColor clearColor];
        self.calendarVC = vc;
        [self.scrollView addSubview:vc.view];
        [UIView animateWithDuration:0.2 animations:^{
            self.calendarVC.view.JYD_Height = 240;
        }];
    }else {
        [UIView animateWithDuration:0.2 animations:^{
            self.calendarVC.view.JYD_Height = 0;
            self.calendarVC.view.subviews[0].JYD_Height = 0;
        } completion:^(BOOL finished) {
            [self.calendarVC.view removeFromSuperview];
        }];
        
    }
    
}

- (void)setupViews {
    
    [self changeBGImage];

    
    [self.view addSubview:self.scrollView];
    
    //添加上半部分的View
    HLTopView *topView = [HLTopView showTopView];
    self.topView = topView;
    self.topView.delegate = self;
    topView.frame = CGRectMake(0, 0, SSScreenW, SSScreenH - 340);
    [self.scrollView addSubview:topView];
    
    //获取当天日期
    //1.获取当前时间戳
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSDate *dateNow = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    fomatter.dateFormat = @"MMMd日";
    NSString *time = [fomatter stringFromDate:dateNow];
    self.title = time;
    
    //上下拉控件
    [self setupDragView];
    

    
}
#pragma mark - 加载新数据
- (void)loadNewDataWithCity:(NSString *)cityName andProvince:(NSString *)provinceName{
    
    self.cityName = cityName;
    self.provinceName = provinceName;
    
    NSString *city = cityName;
    NSString *key = appkey;
    NSString *province = provinceName;
    
    NSDictionary *parameters = NSDictionaryOfVariableBindings(province,key,city);
    
    self.topView.statusAct.hidden = NO;
    self.topView.stautsLabel.text = @"更新数据";
    self.topView.stautsLabel.textAlignment = NSTextAlignmentCenter;
    [self.topView.statusAct startAnimating];
    
    [[HLNetTool shareTools] GET:query parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        self.dataArray = [HLWeatherModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        
        //创建底部View
        HLBottomViewController *bottomVC = [[HLBottomViewController alloc] init];
        bottomVC.cityName = city;
        self.bottomVC = bottomVC;
        bottomVC.view.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame) + 240, SSScreenW, 100);
        [self.scrollView addSubview:bottomVC.view];

        for (HLWeatherModel *weatherModel in self.dataArray) {
            self.topView.model = weatherModel;
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    



}


#pragma mark - barClick
- (void)listBarClick {
    
}

#pragma mark - topViewDelegate
- (void)didClickAirFaceBookInTopView {
    HLPhotosViewController *photoVC = [[HLPhotosViewController alloc] init];
    
    [self.navigationController pushViewController:photoVC animated:YES];
    
    [self.bottomVC.view removeFromSuperview];

    
}

- (void)didClickTempLabelInTopView {
    [self loadNewDataWithCity:@"广州" andProvince:@"广东省"];
    [self.bottomVC.view removeFromSuperview];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
   
    if (offset > 70.0) {
        [self dragUpShowdetailFace];
    }
}

#pragma mark - 上拉面板
- (void)dragUpShowdetailFace {
    HLDetailViewController *detailVC = [[HLDetailViewController alloc] init];
    detailVC.transitioningDelegate = self;
    detailVC.modalPresentationStyle = UIModalPresentationCustom;
    detailVC.dataArray = self.dataArray;
    [self presentViewController:detailVC animated:YES completion:nil];

}

#pragma mark - 自定义转场动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [HLPresentAnimator new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    
}

#pragma mark - get
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)changeBGImage {
    UIImageView *bg = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:bg];
    bg.image = [UIImage imageNamed:@"IMG_5061"];
    self.image = bg.image;

}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SSScreenW, SSScreenH + 63)];
        sc.delegate = self;
        sc.contentSize = CGSizeMake(0, self.view.JYD_Height + 64 );
        
        _scrollView = sc;
    }
    return _scrollView;
}

- (void)setupDragView {
    UIImageView *dragup = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"up"]];
    dragup.JYD_CenterX = self.view.JYD_CenterX;
    dragup.JYD_CenterY = CGRectGetMaxY(self.view.frame) + 20;
    dragup.JYD_Width = 32;
    dragup.JYD_Height = 22;
    self.dragView = dragup;
    [self.scrollView addSubview:dragup];
}
@end
