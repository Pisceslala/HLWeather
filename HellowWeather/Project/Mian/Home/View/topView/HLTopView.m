//
//  HLTopView.m
//  HellowWeather
//
//  Created by Pisces on 2017/6/30.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLTopView.h"

@interface HLTopView ()


/**
 温度
 */
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

@property (weak, nonatomic) IBOutlet UILabel *pointLabel;

/**
 天气图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;

/**
 天气
 */
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;

/**
 湿度
 */
@property (weak, nonatomic) UILabel *humidity;

/**
 空气质量
 */
@property (weak, nonatomic) UIProgressView *progressView;

@property (weak, nonatomic) UIView *airFacebook;

@property (weak, nonatomic) UILabel *airConditionLabel;


@end

@implementation HLTopView

- (void)awakeFromNib {
    [super awakeFromNib];
    

}

+(instancetype)showTopView {
    return [[[NSBundle mainBundle] loadNibNamed:@"HLTopView" owner:nil options:nil] lastObject];
}

+ (void)show {
    [[[NSBundle mainBundle] loadNibNamed:@"HLTopView" owner:nil options:nil] lastObject];
}

#pragma mark - 设置数据
- (void)setModel:(HLWeatherModel *)model {
    _model = model;
    
    NSString *subStr = [model.temperature substringToIndex:2];
    
    self.temperatureLabel.text = subStr;
    
    NSLog(@"%@",model.weather);
    
    //天气和城市拼接显示
    self.weatherLabel.attributedText = [self attributedStringWithImage:@"坐标27x27" AppendString:[NSString stringWithFormat:@"%@ | %@",model.city,model.weather]];
    
    
    //湿度
    self.humidity.attributedText = [self attributedStringWithImage:@"湿度" AppendString:model.humidity];
    
    [self airFacebook];
    self.airConditionLabel.text = [NSString stringWithFormat:@"空气质量指数:%@",model.airCondition];
    self.progressView.progress = (model.pollutionIndex  / 100) + 0.5;

    
    NSLog(@"%lf",model.pollutionIndex / 100);
    //天气大图
    if ([model.weather isEqualToString:@"晴"]) {
        [self weatherImageWithName:@"晴"];
    }else if ([model.weather isEqualToString:@"阴"]) {
        [self weatherImageWithName:@"阴天"];
    }else if ([model.weather isEqualToString:@"小雨"]) {
        [self weatherImageWithName:@"小雨"];
    }else if ([model.weather isEqualToString:@"多云"]) {
        [self weatherImageWithName:@"多云"];
    }else if ([model.weather isEqualToString:@"雷阵雨"] || [model.weather isEqualToString:@"阵雨"]) {
        [self weatherImageWithName:@"阵雨"];
    }else if ([model.weather isEqualToString:@"雷雨"] || [model.weather isEqualToString:@"零散雷雨"]) {
        [self weatherImageWithName:@"雷阵雨"];
    }
    
}

- (void)weatherImageWithName:(NSString *)imageName {
    self.weatherImage.contentMode = UIViewContentModeScaleAspectFit;
    self.weatherImage.image = [UIImage imageNamed:imageName];
}

#pragma mark - 图文混排
- (NSAttributedString *)attributedStringWithImage:(NSString *)imageName AppendString:(NSString *)text {
    
    NSTextAttachment *chment = [[NSTextAttachment alloc] init];
    chment.image = [UIImage imageNamed:imageName];
    chment.bounds = CGRectMake(0, -2, 17, 17);
    NSAttributedString *imageAttributed = [NSAttributedString attributedStringWithAttachment:chment];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:imageAttributed];
    NSMutableAttributedString *textAttributed = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedText appendAttributedString:textAttributed];
    return attributedText;
}


#pragma mark - get
- (UILabel *)humidity {
    if (_humidity == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.weatherLabel.JYD_X, CGRectGetMaxY(self.weatherLabel.frame)+5, self.weatherLabel.JYD_Width, 21)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:17];
        label.shadowColor = [UIColor darkGrayColor];
        label.shadowOffset = CGSizeMake(1, 1);
        _humidity = label;
        [self addSubview:self.humidity];
    }
    return _humidity;
}



- (UIView *)airFacebook {
    if (_airFacebook == nil) {
        UIView *view = [[UIView alloc] initWithFrame: CGRectMake(self.humidity.JYD_X, CGRectGetMaxY(self.humidity.frame)+5, self.weatherLabel.JYD_Width, 31)];
        view.backgroundColor = [UIColor colorWithRed:139/255.0 green:163/255.0 blue:158/255.0 alpha:0.6];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 5;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 3, view.JYD_Width, 13)];
        textLabel.font = [UIFont systemFontOfSize:13];
        textLabel.textColor = [UIColor whiteColor];
        self.airConditionLabel = textLabel;
        [view addSubview:textLabel];
        
        UIProgressView *pro = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        pro.progressTintColor = [UIColor greenColor];
        pro.trackTintColor = [UIColor lightGrayColor];
        pro.frame = CGRectMake(3, CGRectGetMaxY(textLabel.frame) + 5, textLabel.JYD_Width - 6, 5);
        self.progressView = pro;
        [view addSubview:pro];
        _airFacebook = view;
        [self addSubview:_airFacebook];
        
        //添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(airFacebookDidClick)];
        [self.airFacebook addGestureRecognizer:tap];
        
    }
    return _airFacebook;
}

- (void)airFacebookDidClick {
    __weak typeof(self)weakSelf = self;
    if ([weakSelf.delegate respondsToSelector:@selector(didClickAirFaceBookInTopView)]) {
        [weakSelf.delegate didClickAirFaceBookInTopView];
    }
}

@end
