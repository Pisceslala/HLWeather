//
//  HLConst.m
//  HellowWeather
//
//  Created by Pisces on 2017/6/30.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLConst.h"


//base
NSString * const BASEURL = @"http://apicloud.mob.com/";
//APPKEY
NSString * const appkey = @"1f1288f2e04f0";

/********** 天气预报 *************/
//根据城市名查询天气
NSString * const query = @"v1/weather/query";
//城市列表
NSString * const citys = @"v1/weather/citys";
//天气类型
NSString * const type = @"v1/weather/type";

/********** 空气质量 *************/
NSString * const environmentQuery = @"environment/query";
//城市列表
NSString * const environmentCitys = @"environment/citys";
