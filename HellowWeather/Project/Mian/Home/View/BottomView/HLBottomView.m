//
//  HLBottomView.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/1.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLBottomView.h"

@interface HLBottomView ()
//容器
@property (strong, nonatomic) UIView *contentView;
//title
@property (strong, nonatomic) UILabel *weatherTitle;
//image
@property (strong, nonatomic) UIImageView *weatherImage;
//时间
@property (strong, nonatomic) UILabel *dateLabel;

@end

@implementation HLBottomView

- (instancetype)init {
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


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    //容器
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SSScreenW / 4, 100)];
    
    self.contentView = contentView;
    [self addSubview:contentView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:11];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    self.weatherTitle = label;
    [self.contentView addSubview:label];
    
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.weatherTitle.frame)+8, self.contentView.frame.size.width - 30, 30)];
    
    
    self.weatherImage = imageV;
    [self.contentView addSubview:imageV];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, CGRectGetMaxY(self.weatherImage.frame), self.contentView.frame.size.width, 30)];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.font = [UIFont systemFontOfSize:13];
    dateLabel.textColor = [UIColor whiteColor];
    self.dateLabel = dateLabel;
    [self.contentView addSubview:dateLabel];
    
}

- (void)setFutuerModel:(futureModel *)futuerModel {
    _futuerModel = futuerModel;
    
    NSString * weather = futuerModel.dayTime;
    NSString * temp = futuerModel.temperature;
    self.weatherTitle.text = [NSString stringWithFormat:@"%@°     %@",temp,weather];
    
    self.dateLabel.text = futuerModel.week;
    
    
    if ([weather isEqualToString:@"晴"]) {
        [self weatherImageWithName:@"晴"];
    }else if ([weather isEqualToString:@"阴"]) {
        [self weatherImageWithName:@"云"];
    }else if ([weather isEqualToString:@"小雨"] || [weather isEqualToString:@"小雨-中雨"]) {
        [self weatherImageWithName:@"小雨"];
    }else if ([weather isEqualToString:@"多云"]) {
        [self weatherImageWithName:@"多云"];
    }else if ([weather isEqualToString:@"雷阵雨"]) {
        [self weatherImageWithName:@"阵雨"];
    }else if ([weather isEqualToString:@"雷雨"] || [weather isEqualToString:@"零散雷雨"]) {
        [self weatherImageWithName:@"雷阵雨"];
    }else if ([weather isEqualToString:@"中雨"]) {
        [self weatherImageWithName:@"中雨"];
    }else if ([weather isEqualToString:@"大雨"]) {
        [self weatherImageWithName:@"大雨"];
    }
    
}

- (void)weatherImageWithName:(NSString *)imageName {
    self.weatherImage.contentMode = UIViewContentModeScaleAspectFit;
    self.weatherImage.image = [UIImage imageNamed:imageName];
}
@end
