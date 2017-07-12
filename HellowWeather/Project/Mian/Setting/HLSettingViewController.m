//
//  HLSettingViewController.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/12.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLSettingViewController.h"
#import "ClearCacheTool.h"
@interface HLSettingViewController ()

@end

@implementation HLSettingViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = @"清理缓存";
    CGFloat cacheSize = [[ClearCacheTool shareClearCacheTools] getCacheTotalSize];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2lfM",cacheSize];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [AlertControllerTool alertMesasge:@"是否清理缓存" sureTitle:@"确定" cancelTitle:@"取消" confirmHandler:^(UIAlertAction *action) {
        [[ClearCacheTool shareClearCacheTools] clearCache];
        [self.tableView reloadData];
    } cancleHandler:nil];
}


@end
