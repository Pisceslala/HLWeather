//
//  HLAirTabelHeader.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/4.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLAirTabelHeader.h"

@interface HLAirTabelHeader ()

@property (strong, nonatomic) UILabel *title_Label;

@end

@implementation HLAirTabelHeader

-(instancetype)init {
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}


- (void)setupViews {
    self.backgroundColor = [UIColor orangeColor];
    UILabel *title_lable = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width, 20)];
    title_lable.font = [UIFont fontWithName:@"KohinoorTelugu-Regular" size:13];
    title_lable.textAlignment = NSTextAlignmentLeft;
    title_lable.textColor = [UIColor colorWithRed:245/255.0 green:36/255.0 blue:67/255.0 alpha:1];
    title_lable.text = @"Tap Here to Hide";
    self.title_Label = title_lable;
    [self addSubview:title_lable];
    self.isOpen = YES;
    //手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewEvent)];
    [self addGestureRecognizer:tap];
}

- (void)headerViewEvent {
    self.title_Label.text = @"Tap Here to Show";
    
    __weak typeof(self)weakSelf = self;
    if ([weakSelf.delegate respondsToSelector:@selector(didClickHeaderWithTap)]) {
        [weakSelf.delegate didClickHeaderWithTap];
    }
}
@end
