//
//  HLAirTableController.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/4.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLAirTableController.h"
#import "HLAirModel.h"
#import <MJExtension.h>
#import "HLAirTabelHeader.h"
#import "HLAirCell.h"
@interface HLAirTableController ()<HLAirTabelHeaderDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) HLAirTabelHeader *headerView;

@end

@implementation HLAirTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewConfiguration];
    
}
#pragma mark - 初始化
- (void)viewConfiguration {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.rowHeight = 60;
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    HLAirTabelHeader *headerView = [[HLAirTabelHeader alloc] initWithFrame:CGRectMake(0, 0, SSScreenW, 30)];
    headerView.delegate = self;
    self.headerView = headerView;
    self.tableView.tableHeaderView = headerView;
    
    [self.tableView registerClass:[HLAirCell class] forCellReuseIdentifier:@"AirCellFlag"];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return self.fetureData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLAirCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AirCellFlag"];
    
    HLAirFetModel *model = self.dataArray[indexPath.row];
    
    cell.fetModel = model;
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)didClickHeaderWithTap {
    
    if (self.headerView.isOpen) {
        [UIView animateWithDuration:0.3f animations:^{
            self.tableView.JYD_Height = 30;
            self.view.backgroundColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.4f];
            for (HLAirCell *cell in self.tableView.visibleCells) {
                cell.isCellOpen = self.headerView.isOpen;
            }
        }];
    }else {
        [UIView animateWithDuration:0.2f animations:^{
            self.tableView.JYD_Height = self.fetureData.count * 60 + 30;
            self.view.backgroundColor = [UIColor whiteColor];
            for (HLAirCell *cell in self.tableView.visibleCells) {
                cell.isCellOpen = self.headerView.isOpen;
            }

        }];
    }
    self.headerView.isOpen = !self.headerView.isOpen;

    
}


- (void)setFetureData:(NSMutableArray *)fetureData {
    _fetureData = fetureData;
   
    NSMutableArray *data = [HLAirFetModel mj_objectArrayWithKeyValuesArray:fetureData];
    for (HLAirFetModel *model in data) {
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
