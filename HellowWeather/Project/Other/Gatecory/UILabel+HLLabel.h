//
//  UILabel+HLLabel.h
//  HellowWeather
//
//  Created by Pisces on 2017/7/11.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (HLLabel)

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font;

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW;
@end
