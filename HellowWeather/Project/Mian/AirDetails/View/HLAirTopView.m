//
//  HLAirTopView.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/3.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLAirTopView.h"
#import "ZFChart.h"
@interface HLAirTopView ()<ZFCirqueChartDelegate,ZFCirqueChartDataSource>

@property (strong, nonatomic) ZFCirqueChart *chartView;

@property (strong, nonatomic) NSMutableArray *aqiArray;


@end

@implementation HLAirTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}
- (instancetype)init {
    if (self = [super init]) {
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

#pragma mark - 初始化
- (void)setupViews {
    //圆环图
    ZFCirqueChart *chartView = [[ZFCirqueChart alloc] initWithFrame:CGRectMake(0, 0, SSScreenW, 300)];
    chartView.backgroundColor = [UIColor clearColor];
    chartView.dataSource = self;
    chartView.delegate = self;
    chartView.cirquePatternType = kCirquePatternTypeForDefaultWithShadow;
    self.chartView = chartView;
    self.chartView.isResetMaxValue = YES;
    [self addSubview:chartView];
    
    
}

#pragma mark - dataSource
- (NSArray *)valueArrayInCirqueChart:(ZFCirqueChart *)cirqueChart {
    
    return self.aqiArray;
}
- (id)colorArrayInCirqueChart:(ZFCirqueChart *)cirqueChart {
    return ZFGreen;
}

- (CGFloat)maxValueInCirqueChart:(ZFCirqueChart *)cirqueChart {
    return 100;
}

#pragma mark - deleagte
- (CGFloat)radiusForCirqueChart:(ZFCirqueChart *)cirqueChart {
    return 105;
}


#pragma mark - 设置数据
- (void)setModel:(HLAirModel *)model {
    _model = model;
    self.chartView.textLabel.font = [UIFont systemFontOfSize:100];
    self.chartView.textLabel.text = [NSString stringWithFormat:@"%zd",model.aqi];
    self.chartView.textLabel.textColor = [UIColor whiteColor];
    
    [self.aqiArray addObject:self.chartView.textLabel.text];
    [self.chartView strokePath];
}

- (NSMutableArray *)aqiArray {
    if (_aqiArray == nil) {
        _aqiArray = [NSMutableArray array];
    }
    return _aqiArray;
}
- (void)dealloc {
    [self.aqiArray removeAllObjects];
}


@end
