//
//  HLTopView.h
//  HellowWeather
//
//  Created by Pisces on 2017/6/30.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLWeatherModel.h"

@protocol HLTopViewDelegate <NSObject>

- (void)didClickAirFaceBookInTopView;

@end

@interface HLTopView : UIView

@property (strong, nonatomic) HLWeatherModel *model;

+ (instancetype)showTopView;

@property (weak, nonatomic) id<HLTopViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *stautsLabel;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *statusAct;
@end
