//
//  HLAirCell.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/4.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLAirCell.h"
#import "ZFChart.h"
@interface HLAirCell ()<ZFCirqueChartDelegate,ZFCirqueChartDataSource>

@property (strong, nonatomic) NSMutableArray *aqiArray;

@property (strong, nonatomic) ZFCirqueChart *chartView;

@property (strong, nonatomic) UILabel *qualityLabel;

@property (strong, nonatomic) UILabel *dateLabel;

@end

@implementation HLAirCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadContentView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadContentView {
    //圆环
    ZFCirqueChart *chartView = [[ZFCirqueChart alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    chartView.backgroundColor = [UIColor clearColor];
    chartView.delegate = self;
    chartView.dataSource = self;
    self.chartView = chartView;
    chartView.cirquePatternType = kCirquePatternTypeForDefault;
    self.chartView.isResetMaxValue = YES;
    [self.contentView addSubview:chartView];
    
    //质量label
    UILabel *qualityLabel = [[UILabel alloc] init];
    self.qualityLabel = qualityLabel;
    qualityLabel.textAlignment = NSTextAlignmentCenter;
    qualityLabel.frame = CGRectMake(0,0, 30, 30);

    CGPoint center = qualityLabel.center;
    center.x = CGRectGetMaxX(chartView.frame) + 10;
    center.y = chartView.center.y;
    qualityLabel.center = center;
    
    qualityLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14];
    qualityLabel.textColor = [UIColor greenColor];
    [self.contentView addSubview:qualityLabel];
    
    //时间Label
    CGFloat w = 100;
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, 30)];
    self.dateLabel = dateLabel;
    dateLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:14];
    
    center.x = CGRectGetMaxX(self.contentView.frame) - w;
    center.y = chartView.center.y;
    dateLabel.center = center;
    
    [self.contentView addSubview:dateLabel];
}


#pragma mark - dataSource
- (NSArray *)valueArrayInCirqueChart:(ZFCirqueChart *)cirqueChart {
    
    return self.aqiArray;
}
- (id)colorArrayInCirqueChart:(ZFCirqueChart *)cirqueChart {
    return ZFRandom;
}

- (CGFloat)maxValueInCirqueChart:(ZFCirqueChart *)cirqueChart {
    return 100;
}

#pragma mark - deleagte
- (CGFloat)radiusForCirqueChart:(ZFCirqueChart *)cirqueChart {
    return 15;
}

- (CGFloat)lineWidthInCirqueChart:(ZFCirqueChart *)cirqueChart {
    return 3;
}

- (void)setFetModel:(HLAirFetModel *)fetModel {
    _fetModel = fetModel;
    
    self.qualityLabel.text = fetModel.quality;
    
    [self.aqiArray addObject:[NSString stringWithFormat:@"%zd",fetModel.aqi]];
    
    NSString *moth = [fetModel.date substringWithRange:NSMakeRange(6, 1)];
    NSString *day = [fetModel.date substringWithRange:NSMakeRange(8, 2)];
    self.dateLabel.text = [NSString stringWithFormat:@"%@月%@日",moth,day];
    
    self.chartView.textLabel.font = [UIFont systemFontOfSize:10];
    self.chartView.textLabel.text = [NSString stringWithFormat:@"%zd",fetModel.aqi];
    
    [self.chartView strokePath];
    [self.aqiArray removeAllObjects];
}

- (NSMutableArray *)aqiArray {
    if (_aqiArray == nil) {
        _aqiArray = [NSMutableArray array];
    }
    return _aqiArray;
}

#pragma mark - 闭合动画
- (void)setIsCellOpen:(BOOL)isCellOpen {
    _isCellOpen = isCellOpen;
    if (isCellOpen) {
        [UIView animateWithDuration:1.0f delay:0 usingSpringWithDamping:1.0f initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            self.chartView.frame = CGRectMake(0, -50, 50, 50);
            
            CGPoint center = self.qualityLabel.center;
            
            center.x = CGRectGetMaxX(self.chartView.frame) + 10;
            
            center.y = self.chartView.center.y;
            
            self.qualityLabel.center = center;
            
            self.chartView.alpha = 0.3f;
          
            self.dateLabel.alpha = 0.3f;

        } completion:^(BOOL finished) {
            
        }];
    }else {
        [UIView animateWithDuration:1.0f animations:^{
            
            self.chartView.frame = CGRectMake(0, 0, 50, 50);
            
            CGPoint center = self.qualityLabel.center;
            
            center.x = CGRectGetMaxX(self.chartView.frame) + 10;
            
            center.y = self.chartView.center.y;
            
            self.qualityLabel.center = center;
            
            self.chartView.alpha = 1.0f;
            
            self.dateLabel.alpha = 1.0f;
            
        
        } completion:^(BOOL finished) {
            
        }];
    }
}
@end
