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
#import <UIImageView+WebCache.h>
#import "HLPicBrowserViewController.h"
@interface HLPhotosViewController ()

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSMutableArray *historyArray;

@property (assign, nonatomic) NSInteger newCount;

@property (assign, nonatomic) NSInteger oldCunt;
@end

@implementation HLPhotosViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.rowHeight = 220;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    MJRefreshBackNormalFooter *footView = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreOldestData)];
    [footView setTintColor:[UIColor blackColor]];
    self.tableView.mj_footer = footView;
   
    MJRefreshStateHeader *headRef = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMoreNewData)];
    
    self.tableView.mj_header = headRef;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HLPhotoCell class]) bundle:nil] forCellReuseIdentifier:@"photoCellFlag"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //查看缓存是否有值
    if ([[[PINCache sharedCache] objectForKey:@"newCount"] integerValue]) {
        self.newCount = [[[PINCache sharedCache] objectForKey:@"newCount"] integerValue];
    }else {
        self.newCount = 0;
    }
    
    if ([[[PINCache sharedCache] objectForKey:@"oldCount"] integerValue]) {
        self.oldCunt = [[[PINCache sharedCache] objectForKey:@"oldCount"] integerValue];
    }else {
        self.oldCunt = 0;
    }

    
    
    [self loadDataFromCache];


}
#pragma mark - 从缓存加载
- (void)loadDataFromCache {
    NSMutableArray *cacheData = [[PINCache sharedCache] objectForKey:PhotoCache];
    
    if (cacheData.count == 0) {
        [self loadNewDataFromNet];
    }else {
        self.dataArray = [HLPhotosModel mj_objectArrayWithKeyValuesArray:cacheData];
        [self.tableView reloadData];
    }
}
#pragma mark - 加载数据
- (void)loadNewDataFromNet {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *client_id = unsplashAppKey;
    NSString *page = @"1";
    NSString *per_page = @"20";
    NSDictionary *parm = NSDictionaryOfVariableBindings(client_id,page,per_page);
    
    [manager GET:unsplashPhotoURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *imageCount = [NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            [imageCount addObject:dict];
        }
        
        for (int i = 0; i < imageCount.count; i++) {
            HLPhotosModel *model = [HLPhotosModel mj_objectWithKeyValues:responseObject[i][@"urls"]];
            [self.dataArray addObject:model];
        }
        
        [self.tableView reloadData];
        
        //缓存
        NSArray *cacheArray = [HLPhotosModel mj_keyValuesArrayWithObjectArray:self.dataArray];
        [[PINCache sharedCache] setObject:cacheArray forKey:PhotoCache];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark - 加载更多数据
- (void)loadMoreOldestData {
    [self loadMoreData:@"oldest"];
    
    [self.tableView.mj_footer beginRefreshing];
}

- (void)loadMoreNewData {
    [self loadMoreData:@"popular"];
    [self.tableView.mj_header beginRefreshing];
}


/**
 加载新的数据和旧的数据

 @param dataStatus 加载数据类型
 */
- (void)loadMoreData:(NSString *)dataStatus {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //参数
    NSString *client_id = unsplashAppKey;
    NSString *page = @"";
    
    //判断是加载新的图片还是旧的图片页码
    if ([dataStatus isEqualToString:@"popular"]) {
        page = [NSString stringWithFormat:@"%zd",++self.newCount];
    }else {
        page = [NSString stringWithFormat:@"%zd",++self.oldCunt];
    }
    
    NSString *per_page = @"10";
    NSString *order_by = dataStatus;
    NSDictionary *parm = NSDictionaryOfVariableBindings(client_id,page,per_page,order_by);
    
    [manager GET:unsplashPhotoURL parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        NSMutableArray *imageCount = [NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            [imageCount addObject:dict];
        }
        
        NSMutableArray *newArray = [NSMutableArray array];
        
        for (int i = 0; i < imageCount.count; i++) {
            HLPhotosModel *model = [HLPhotosModel mj_objectWithKeyValues:responseObject[i][@"urls"]];
            
            [newArray addObject:model];
            
        }
        
        if ([order_by isEqualToString:@"popular"]) {
            [newArray addObjectsFromArray:self.dataArray];
            self.dataArray = newArray;
        }else {
            [self.dataArray addObjectsFromArray:newArray];
        }
        [self.tableView reloadData];
        
        //缓存处理
        NSArray *cacheArray = [HLPhotosModel mj_keyValuesArrayWithObjectArray:self.dataArray];
        [[PINCache sharedCache] setObject:cacheArray forKey:PhotoCache];
        [[PINCache sharedCache] setObject:[NSString stringWithFormat:@"%zd",self.newCount] forKey:@"newCount"];
        [[PINCache sharedCache] setObject:[NSString stringWithFormat:@"%zd",self.oldCunt] forKey:@"oldCount"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SDLOG(@"%@",error);
    }];
    
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photoCellFlag" forIndexPath:indexPath];
   
   
    HLPhotosModel *model = self.dataArray[indexPath.row];
        
    cell.model = model;
    
    return cell;
}

#pragma mark - tableDelegate 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HLPhotosModel *mode = self.dataArray[indexPath.row];
    HLPicBrowserViewController *picVC = [[HLPicBrowserViewController alloc] init];
    picVC.regularURL = mode.regular;
    picVC.fullURL = mode.full;
    [self.navigationController pushViewController:picVC animated:YES];
}

#pragma mark - get
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)historyArray {
    if (_historyArray == nil) {
        _historyArray = [NSMutableArray array];
    }
    return _historyArray;
}

- (void)dealloc {
    SDLOG(@"die");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
