//
//  UIImage+HLUIImage.h
//  HellowWeather
//
//  Created by Pisces on 2017/7/8.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HLUIImage)
- (UIImage *) imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
@end
