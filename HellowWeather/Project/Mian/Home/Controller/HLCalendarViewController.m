//
//  HLCalendarViewController.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/8.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLCalendarViewController.h"
#import <AFNetworking.h>

@interface HLCalendarViewController ()

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation HLCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self loadDataWithDate:@"2017-7-8"];
}

- (void)loadDataWithDate:(NSString *)time {
    NSString *key = appkey;
    NSString *date = time;
    
    NSDictionary *parm = NSDictionaryOfVariableBindings(key,date);
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
    [manage GET:calendarURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SDLOG(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SDLOG(@"%@",error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - get
- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SSScreenW, 240) style:UITableViewStylePlain];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        _tableView = tableView;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - set
- (void)setDate:(NSString *)date {
    _date = date;
}

@end
