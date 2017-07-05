//
//  HLDetailCell.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/5.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLDetailCell.h"
#import "HLWeatherModel.h"
@interface HLDetailCell ()


@end

@implementation HLDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.itemLabel.font = [UIFont fontWithName:@"KohinoorTelugu-Regular" size:15];
    self.itemLabel.textColor = [UIColor colorWithRed:245/255.0 green:36/255.0 blue:67/255.0 alpha:1];
}



@end
