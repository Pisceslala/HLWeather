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
@interface HLPhotosViewController ()

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation HLPhotosViewController

- (void)viewWillAppear:(BOOL)animated {
    [self loadNewDataFromNet];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
}

- (void)loadNewDataFromNet {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *client_id = unsplashAppKey;
    NSDictionary *parm = NSDictionaryOfVariableBindings(client_id);
    
    [manager GET:unsplashPhotoURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        for (NSDictionary *dict in responseObject) {
            HLPhotosModel *model = [HLPhotosModel mj_objectWithKeyValues:dict];
            [self.dataArray addObject:model];
        }
        
        
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

#pragma mark - get
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
