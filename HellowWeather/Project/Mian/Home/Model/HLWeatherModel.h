//
//  HLWeatherModel.h
//  HellowWeather
//
//  Created by Pisces on 2017/6/30.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <Foundation/Foundation.h>
@class futureModel;

@interface HLWeatherModel : NSObject

/**
 空气质量
 */
@property (copy, nonatomic) NSString *airCondition;

/**
 城市
 */
@property (nonatomic, copy) NSString *city;

/**
 感冒指数
 */
@property (nonatomic, copy) NSString *coldIndex;

/**
 日期
 */
@property (nonatomic, copy) NSString *date;

/**
 区县
 */
@property (nonatomic, copy) NSString *distrct;

/**
 穿衣指数
 */
@property (nonatomic, copy) NSString *dressingIndex;

/**
 运动指数
 */
@property (nonatomic, copy) NSString *exerciseIndex;

/**
 湿度
 */
@property (nonatomic, copy) NSString *humidity;

/**
 空气质量指数
 */
@property (assign, nonatomic) CGFloat pollutionIndex;

/**
 省
 */
@property (nonatomic, copy) NSString *province;

/**
 日出时间
 */
@property (nonatomic, copy) NSString *sunrise;

/**
 日落时间
 */
@property (nonatomic, copy) NSString *sunset;

/**
 温度
 */
@property (nonatomic, copy) NSString *temperature;

/**
 天气
 */
@property (nonatomic, copy) NSString *weather;

/**
 星期
 */
@property (nonatomic, copy) NSString *week;

/**
 预报数组
 */
@property (nonatomic, strong) NSArray *future;

/**
 更新时间
 */
@property (nonatomic, copy) NSString *time;

@end

@interface futureModel : NSObject

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *dayTime;

@property (nonatomic, copy) NSString *night;

@property (nonatomic, copy) NSString *temperature;

@property (nonatomic, copy) NSString *week;

@property (nonatomic, copy) NSString *wind;
@end
