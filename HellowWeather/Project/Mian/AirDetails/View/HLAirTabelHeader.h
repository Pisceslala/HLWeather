//
//  HLAirTabelHeader.h
//  HellowWeather
//
//  Created by Pisces on 2017/7/4.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HLAirTabelHeaderDelegate <NSObject>

- (void)didClickHeaderWithTap;

@end

@interface HLAirTabelHeader : UIView

@property (assign, nonatomic) BOOL isOpen;

@property (weak, nonatomic) id<HLAirTabelHeaderDelegate> delegate;


@end
