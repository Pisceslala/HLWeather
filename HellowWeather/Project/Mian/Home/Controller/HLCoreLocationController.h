//
//  HLCoreLocationController.h
//  HellowWeather
//
//  Created by Pisces on 2017/7/11.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLCoreLocationController : NSObject

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *province;

- (void)startShowUserLocation;

@end
