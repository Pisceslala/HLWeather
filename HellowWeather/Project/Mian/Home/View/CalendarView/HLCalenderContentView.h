//
//  HLCalenderContentView.h
//  HellowWeather
//
//  Created by Pisces on 2017/7/11.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLCalendarModel.h"
@interface HLCalenderContentView : UIView

@property (strong, nonatomic) HLCalendarModel *model;

+ (instancetype)showCalendarContentView;

@end
