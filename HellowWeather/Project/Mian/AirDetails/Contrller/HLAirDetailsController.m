//
//  HLAirDetailsController.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/3.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLAirDetailsController.h"
#import "HLAirTopView.h"
#import "HLAirModel.h"
#import <MJExtension.h>
#import "HLAirTableController.h"
@interface HLAirDetailsController ()

@property (nonatomic, strong) HLAirTopView *topView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation HLAirDetailsController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.hidesBarsOnSwipe = YES;
    //加载数据
    [self loadNewDataWithCity:self.cityName andProvince:self.provinceName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews {
    
    
    
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:bg];
    bg.image = [UIImage imageNamed:@"bg1"];
    
    [self.view addSubview:self.scrollView];
    
    HLAirTopView *topView = [[HLAirTopView alloc] initWithFrame:CGRectMake(0, 64, SSScreenW, 300)];
    self.topView = topView;
    [self.scrollView addSubview:topView];

}

#pragma mark - 加载数据
- (void)loadNewDataWithCity:(NSString *)cityName andProvince:(NSString *)provinceName {
    
    NSString *city = cityName;
    NSString *province = provinceName;
    NSString *key = appkey;
    NSDictionary *parm = NSDictionaryOfVariableBindings(province,key,city);
    [[HLNetTool shareTools] GET:environmentQuery parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res === %@",responseObject);
        
        self.dataArray = [HLAirModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        for (HLAirModel *model in self.dataArray) {
            self.topView.model = model;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark - get
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        UIScrollView *sc = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        sc.bounces = NO;
        //sc.showsVerticalScrollIndicator = NO;
        sc.showsHorizontalScrollIndicator = NO;
        sc.contentSize = CGSizeMake(0,2 * SSScreenH);
        _scrollView = sc;
    }
    return _scrollView;
}

#pragma mark - set
- (void)setBgImage:(UIImage *)bgImage {
    _bgImage = bgImage;
}

- (void)setCityName:(NSString *)cityName {
    _cityName = cityName;
}

-(void)setProvinceName:(NSString *)provinceName {
    _provinceName = provinceName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"HLAirDetailsController dealloc");
}

@end
