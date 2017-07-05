//
//  HLDetailCell.h
//  HellowWeather
//
//  Created by Pisces on 2017/7/5.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLWeatherModel;
@interface HLDetailCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;

@property (strong, nonatomic) HLWeatherModel *model;
@end
