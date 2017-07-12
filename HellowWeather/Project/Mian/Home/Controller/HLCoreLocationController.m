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

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation HLCoreLocationController


//开始定位
-(void)startShowUserLocation{
    //判断定位操作是否被允许
    
    if([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init] ;
        self.locationManager.delegate = self;
        //设置定位精度
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;//每隔多少米定位一次（这里的设置为每隔百米)
        if ([[[UIDevice currentDevice] systemVersion]floatValue]>=8.0) {
            //使用应用程序期间允许访问位置数据
            [self.locationManager requestWhenInUseAuthorization];
        }
        // 开始定位
        [self.locationManager startUpdatingLocation];
    }else {
        //提示用户无法进行定位操作
        NSLog(@"%@",@"定位服务当前可能尚未打开，请设置打开！");
        
    }
}
#pragma mark - CoreLocation Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations

{
    
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    [self.locationManager stopUpdatingLocation];
    
    NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 5.0) return;
    
    //获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     {
         CLPlacemark *placemark = [array objectAtIndex:0];
             //获取城市
         NSString *currCity = [placemark.locality substringToIndex:2];
         NSString *province = placemark.administrativeArea;
         SDLOG(@"%@-%@",currCity,province);
         NSDictionary *dict = NSDictionaryOfVariableBindings(currCity,province);
         [[NSNotificationCenter defaultCenter] postNotificationName:@"loadDataWithLocation" object:dict];
         
         //缓存
         [[PINCache sharedCache] setObject:currCity forKey:CITYNAME];
         [[PINCache sharedCache] setObject:province forKey:PROVINCE];
     }];
    
    
    
}




@end
