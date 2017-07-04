//
//  HLBottomViewController.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/1.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLBottomViewController.h"
#import "HLBottomView.h"
#import <MJExtension.h>
@interface HLBottomViewController ()

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) NSMutableArray *futureArray;

@end

@implementation HLBottomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载数据
    [self loadNewDataWithCity:self.cityName];
    

}


- (void)setupViews {
    
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i < self.futureArray.count; i ++) {
        CGFloat w = SSScreenW / 4;
        CGFloat x = i * w;
        HLBottomView *bottomView = [[HLBottomView alloc] initWithFrame:CGRectMake(x, 0, w, 100)];
        bottomView.futuerModel = self.futureArray[i];
        [self.scrollView addSubview:bottomView];
    }
    
}


- (void)loadNewDataWithCity:(NSString *)cityName {
    NSString *city = cityName;
    NSString *key = appkey;
    NSString *province = @"广东省";
    
    NSDictionary *parameters = NSDictionaryOfVariableBindings(province,key,city);
    
    [[HLNetTool shareTools] GET:query parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.futureArray = [futureModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][0][@"future"]];
        
        [self setupViews];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"erroe = %@", error);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - get
- (UIScrollView *)scrollView {
    
    if (_scrollView == nil) {
        CGFloat height = 100;
        
        UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SSScreenW, height)];
        sc.contentSize = CGSizeMake(self.futureArray.count * (SSScreenW / 4), 0);
        sc.bounces = NO;
        sc.showsHorizontalScrollIndicator = NO;
        _scrollView = sc;
        
        
    }
    return _scrollView;
    
}

- (NSMutableArray *)futureArray {
    if (_futureArray == nil) {
        _futureArray = [NSMutableArray array];
    }
    return _futureArray;
}

- (void)setCityName:(NSString *)cityName {
    _cityName = cityName;
}
@end
