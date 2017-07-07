//
//  HLPhotosViewController.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/7.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLPhotosViewController.h"
#import <AFNetworking.h>
#import "HLPhotosModel.h"
#import <MJExtension.h>
#import "HLPhotoCell.h"
@interface HLPhotosViewController ()

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation HLPhotosViewController

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNewDataFromNet];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HLPhotoCell class]) bundle:nil] forCellReuseIdentifier:@"photoCellFlag"];
    self.tableView.rowHeight = 220;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)loadNewDataFromNet {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *client_id = unsplashAppKey;
    NSDictionary *parm = NSDictionaryOfVariableBindings(client_id);
    
    [manager GET:unsplashPhotoURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        for (int i = 0; i < 10; i++) {
            HLPhotosModel *model = [HLPhotosModel mj_objectWithKeyValues:responseObject[i][@"urls"]];
            [self.dataArray addObject:model];
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photoCellFlag" forIndexPath:indexPath];
    
    HLPhotosModel *model = self.dataArray[indexPath.row];
    
    cell.model = model;
    
    return cell;
}


#pragma mark - get
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


    

@end
