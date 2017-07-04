//
//  UIView+JYDFrame.h
//  SweetCandy
//
//  Created by Pisces on 2016/11/24.
//  Copyright © 2016年 Pisces. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JYDFrame)
//X坐标
@property (assign, nonatomic) CGFloat JYD_X;

//Y坐标
@property (assign, nonatomic) CGFloat JYD_Y;

//中心点X坐标
@property (assign, nonatomic) CGFloat JYD_CenterX;

//中心点Y坐标
@property (assign, nonatomic) CGFloat JYD_CenterY;

//坐标点
@property (assign, nonatomic) CGPoint JYD_Origin;

//宽度
@property (assign, nonatomic) CGFloat JYD_Width;

//高度
@property (assign, nonatomic) CGFloat JYD_Height;

//尺寸
@property (assign, nonatomic) CGSize JYD_Size;

@end
