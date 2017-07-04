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
#import "HLAirDetailsController.h"
@interface HLHomeViewController ()<HLTopViewDelegate>

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *futureDataArray;

@property (nonatomic, strong) HLTopView *topView;

@property (nonatomic, strong) HLBottomViewController *bottomVC;



@end

@implementation HLHomeViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    // 设置一个空的 shadowImage 来实现
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    //根据城市名称加载
    [self loadNewDataWithCity:@"广州" andProvince:@"广东省"];

    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.bottomVC.view removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor orangeColor];
    
    [self setupViews];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(listBarClick)];
    
}

- (void)setupViews {
    
    [self changeBGImage];
    //添加上半部分的View
    HLTopView *topView = [HLTopView showTopView];
    self.topView = topView;
    self.topView.delegate = self;
    topView.frame = CGRectMake(0, 0, SSScreenW, SSScreenH - 100);
    [self.view addSubview:topView];
    
    //获取当天日期
    //1.获取当前时间戳
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSDate *dateNow = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    fomatter.dateFormat = @"MMMd日";
    NSString *time = [fomatter stringFromDate:dateNow];
    self.title = time;
}
#pragma mark - 加载新数据
- (void)loadNewDataWithCity:(NSString *)cityName andProvince:(NSString *)provinceName{

    NSString *city = cityName;
    NSString *key = appkey;
    NSString *province = provinceName;
    
    NSDictionary *parameters = NSDictionaryOfVariableBindings(province,key,city);
    
    [[HLNetTool shareTools] GET:query parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSLog(@"%@",responseObject);
        
        self.dataArray = [HLWeatherModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        
        //创建底部View
        HLBottomViewController *bottomVC = [[HLBottomViewController alloc] init];
        bottomVC.cityName = city;
        self.bottomVC = bottomVC;
        bottomVC.view.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), SSScreenW, 100);
        [self.view addSubview:bottomVC.view];

    
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
    HLAirDetailsController *vc = [[HLAirDetailsController alloc] init];
    vc.bgImage = self.image;
    vc.title = @"空气质量指数";
    [self.navigationController pushViewController:vc animated:YES];
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
    bg.image = [UIImage imageNamed:@"IMG_5051"];
    self.image = bg.image;

}
@end
