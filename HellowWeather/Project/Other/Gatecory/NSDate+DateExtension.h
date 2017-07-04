//
//  NSDate+DateExtension.h
//  SweetCandy
//
//  Created by Pisces on 2016/11/25.
//  Copyright © 2016年 Pisces. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DateExtension)

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  是否为今天今年
 */
- (BOOL)isThisYears;

/**
 *  将时间戳转化为字符串
 */
+ (NSString *)dateWithtimeStamp:(NSString *)timeStringStamp;

@end
