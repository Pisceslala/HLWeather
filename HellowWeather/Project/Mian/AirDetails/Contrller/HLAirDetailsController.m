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

@property (nonatomic, strong) HLAirTableController *contentVC;
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
           bg.image = [UIImage imageNamed:@"bg1"];
    
    [self.view addSubview:bg];
    
    [self.view addSubview:self.scrollView];
    
    HLAirTopView *topView = [[HLAirTopView alloc] initWithFrame:CGRectMake(0, 64, SSScreenW, 300)];
             self.topView = topView;
   
    [self.scrollView addSubview:topView];
    
    HLAirTableController *contentVC = [[HLAirTableController alloc] initWithStyle:UITableViewStylePlain];
                     self.contentVC = contentVC;


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
            
            self.topView.model          = model;
            
            self.contentVC.fetureData   = model.fetureData;
            
            self.contentVC.view.frame   = CGRectMake(0, CGRectGetMaxY(self.topView.frame), SSScreenW, (model.fetureData.count * 60) + 30);
            
            [self.scrollView addSubview:self.contentVC.view];
            
            self.scrollView.contentSize = CGSizeMake(0, self.topView.JYD_Height + self.contentVC.view.JYD_Height + 60);

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
        sc.bounces  = YES;
        sc.showsHorizontalScrollIndicator = NO;
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
    [self.contentVC.view removeFromSuperview];
}

@end
