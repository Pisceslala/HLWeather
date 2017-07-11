//
//  HLCoreLocationController.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/11.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLCoreLocationController.h"
#import <CoreLocation/CoreLocation.h>
@interface HLCoreLocationController ()<CLLocationManagerDelegate>

@property(readonly, nonatomic) CLLocationCoordinate2D coordinate;

@property (strong, nonatomic) CLLocationManager *mgr;

@end

@implementation HLCoreLocationController


- (void)startShowUserLocation {
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    manager.delegate = self;
    self.mgr = manager;
    self.mgr.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.mgr.distanceFilter = 500;
    
    if([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
    {
        // 主动要求用户对我们的程序授权, 授权状态改变就会通知代理
        //
        [self.mgr requestAlwaysAuthorization]; // 请求前台和后台定位权限
        
    }
    
    [manager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    [manager stopUpdatingLocation];
    
    CLLocation *newLocation = [locations lastObject];
    
    SDLOG(@"%zd",locations.count);
    
    //初始化编码器
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *mark = [placemarks lastObject];
        //获取当前城市位置信息，其中CLPlacemark包括name、thoroughfare、subThoroughfare、locality、subLocality等详细信息
        //[self.annotationView setValue:mark.name forKey:@"title"];
        NSString *province = mark.administrativeArea;
        NSString *city = [mark.locality substringToIndex:2];
        NSDictionary *dict = NSDictionaryOfVariableBindings(city,province);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadDataWithLocation" object:dict];
    }];

}




@end
