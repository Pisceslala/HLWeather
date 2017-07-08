//
//  HLCalendarModel.h
//  HellowWeather
//
//  Created by Pisces on 2017/7/8.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLCalendarModel : NSObject

/**
 不宜
 */
@property (nonatomic, copy) NSString *avoid;

/**
 日期
 */
@property (nonatomic, copy) NSString *date;

/**
 节假日
 */
@property (nonatomic, copy) NSString *holiday;

/**
 农历
 */
@property (nonatomic, copy) NSString *lunar;

/**
 农历年
 */
@property (nonatomic, copy) NSString *lunarYear;

/**
 宜
 */
@property (nonatomic, copy) NSString *suit;

/**
 星期几
 */
@property (nonatomic, copy) NSString *weekday;

/**
 生肖
 */
@property (nonatomic, copy) NSString *zodiac;

@end
