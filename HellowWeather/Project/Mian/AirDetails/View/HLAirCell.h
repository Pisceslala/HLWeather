//
//  HLAirCell.h
//  HellowWeather
//
//  Created by Pisces on 2017/7/4.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLAirModel.h"
@interface HLAirCell : UITableViewCell

@property (nonatomic, strong) HLAirFetModel *fetModel;

@property (assign, nonatomic) BOOL isCellOpen;

@end
