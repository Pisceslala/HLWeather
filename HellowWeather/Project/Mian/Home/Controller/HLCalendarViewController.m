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

@interface HLCalendarViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSArray *titleArray;

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation HLCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.view.layer.borderWidth = 0.3;
    self.view.layer.borderColor = [[UIColor whiteColor] CGColor];
    
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
        
        self.titleArray = @[@"不宜",@"日期",@"节假日",@"农历",@"农历年",@"宜",@"星期几",@"生肖"];
        
        HLCalendarModel *model = [HLCalendarModel mj_objectWithKeyValues:responseObject[@"result"]];
        
        [self.dataArray addObject:model];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.detailTextLabel.text = [self detailTextWithForRow:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

//每一行显示的数据
- (NSString *)detailTextWithForRow:(NSIndexPath *)indexPath {
    HLCalendarModel *model = self.dataArray[0];
    switch (indexPath.row) {
        case 0:
            return  model.avoid;
            break;
        case 1:
            return  model.date;
            break;
        case 2:
            if (model.holiday) {
                return  model.holiday;
            }else {
                return  @"今天没有节日哦~";
            }
            break;
        case 3:
             return model.lunar;
            break;
        case 4:
            return model.lunarYear;
            break;
        case 5:
            return model.suit;
            break;
        case 6:
            return model.weekday;
            break;
        case 7:
            return model.zodiac;
            break;
        default:
            break;
    }
    return nil;

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
        tableView.bounces = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 50;
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

- (NSArray *)titleArray {
    if (_titleArray == nil) {
        _titleArray = [NSArray array];
    }
    return _titleArray;
}

#pragma mark - set
- (void)setDate:(NSString *)date {
    _date = date;
}

@end
