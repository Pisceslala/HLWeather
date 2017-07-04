//
//  UIView+JYDFrame.m
//  SweetCandy
//
//  Created by Pisces on 2016/11/24.
//  Copyright © 2016年 Pisces. All rights reserved.
//

#import "UIView+JYDFrame.h"

@implementation UIView (JYDFrame)

-(void)setJYD_X:(CGFloat)JYD_X {
    
    CGRect frame = self.frame;
    
    frame.origin.x = JYD_X;
    
    self.frame = frame;
    
}

- (CGFloat)JYD_X {
   
    return self.frame.origin.x;

}

- (void)setJYD_Y:(CGFloat)JYD_Y {
    
    CGRect frame = self.frame;
    
    frame.origin.y = JYD_Y;
    
    self.frame = frame;
    
}

- (CGFloat)JYD_Y {
    
    return self.frame.origin.y;
    
}

- (void)setJYD_CenterX:(CGFloat)JYD_CenterX {
    
    CGPoint center = self.center;
    
    center.x = JYD_CenterX;
    
    self.center = center;
    
}

- (CGFloat)JYD_CenterX {
    
    return self.center.x;
    
}

- (void)setJYD_CenterY:(CGFloat)JYD_CenterY {
    
    CGPoint center = self.center;
    
    center.y = JYD_CenterY;
    
    self.center = center;
    
}

- (CGFloat)JYD_CenterY {
    
    return self.center.y;
    
}

- (void)setJYD_Origin:(CGPoint)JYD_Origin {
    
    CGRect frame = self.frame;
    
    frame.origin = JYD_Origin;
    
    self.frame = frame;
    
}

- (CGPoint)JYD_Origin {
    
    return self.frame.origin;
    
}

- (void)setJYD_Size:(CGSize)JYD_Size {
    
    CGRect frame = self.frame;
    
    frame.size = JYD_Size;
    
    self.frame = frame;
    
}

- (CGSize)JYD_Size {
    
    return self.frame.size;
    
}

- (void)setJYD_Width:(CGFloat)JYD_Width {
    
    CGRect frame = self.frame;
    
    frame.size.width = JYD_Width;
    
    self.frame = frame;
}

- (CGFloat)JYD_Width {
    
    return self.frame.size.width;
    
}

- (void)setJYD_Height:(CGFloat)JYD_Height {
    
    CGRect frame = self.frame;
    
    frame.size.height = JYD_Height;
    
    self.frame = frame;
    
}

- (CGFloat)JYD_Height {
    
    return self.frame.size.height;
    
}
@end
