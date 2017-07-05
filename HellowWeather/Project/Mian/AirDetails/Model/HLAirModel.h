//
//  HLAirModel.h
//  HellowWeather
//
//  Created by Pisces on 2017/7/3.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLAirModel : NSObject

//no2 = 48;
//pm10 = 33;
//pm25 = 21;
//province = "\U5e7f\U4e1c";
//quality = "\U4f18";
//so2 = 11;
//updateTime = "2017-07-04 14:00:00";

@property (nonatomic, assign) NSInteger aqi;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *district;

@property (nonatomic, strong) NSMutableArray *fetureData;

@property (assign, nonatomic) NSInteger no2;

@property (assign, nonatomic) NSInteger pm10;

@property (assign, nonatomic) NSInteger pm25;

@property (assign, nonatomic) NSInteger so2;

@property (nonatomic, copy) NSString *quality;

@property (nonatomic, copy) NSString *updateTime;

@end

@interface HLAirFetModel : NSObject

@property (nonatomic, assign) NSInteger aqi;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *quality;

@end
