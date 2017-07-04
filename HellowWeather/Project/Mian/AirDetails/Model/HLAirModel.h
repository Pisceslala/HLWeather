//
//  HLAirModel.h
//  HellowWeather
//
//  Created by Pisces on 2017/7/3.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLAirModel : NSObject

@property (nonatomic, assign) NSInteger aqi;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *district;

@property (nonatomic, strong) NSArray *fetureData;

@end
