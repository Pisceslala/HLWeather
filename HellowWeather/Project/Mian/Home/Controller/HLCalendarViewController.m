//
//  HLCalendarViewController.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/8.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLCalendarViewController.h"
#import "HLCalendarModel.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "HLCalenderContentView.h"

@interface HLCalendarViewController ()

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) HLCalenderContentView *calendarView;

@end

@implementation HLCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.layer.masksToBounds = YES;
    self.view.layer.cornerRadius = 8;
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSDate *dateNow = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    fomatter.dateFormat = @"yyyy-M-d";
    NSString *time = [fomatter stringFromDate:dateNow];
    
    [self loadDataWithDate:time];
}

- (void)loadDataWithDate:(NSString *)time {
    NSString *key = appkey;
    NSString *date = time;
    
    NSDictionary *parm = NSDictionaryOfVariableBindings(key,date);
    
    [[HLNetTool shareTools] GET:calendarURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        HLCalendarModel *model = [HLCalendarModel mj_objectWithKeyValues:responseObject[@"result"]];
        
        HLCalenderContentView *calendarView = [HLCalenderContentView showCalendarContentView];
        
        calendarView.model = model;
        
        self.calendarView = calendarView;
        
        calendarView.frame = CGRectMake(0, 0, SSScreenW, 240);
        
        [self.view addSubview:calendarView];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - set
- (void)setDate:(NSString *)date {
    _date = date;
}

@end
