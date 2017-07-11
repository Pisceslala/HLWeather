//
//  HLCalenderContentView.m
//  HellowWeather
//
//  Created by Pisces on 2017/7/11.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLCalenderContentView.h"
#import "TimeLabel.h"
@interface HLCalenderContentView ()

@property (weak, nonatomic) IBOutlet UILabel *todayLabel;
@property (weak, nonatomic) IBOutlet TimeLabel *festivalLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *lunarLabel;
@property (weak, nonatomic) IBOutlet UILabel *lunarDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *advisableLabel;
@property (weak, nonatomic) IBOutlet UILabel *suitableLable;

@end

@implementation HLCalenderContentView

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.todayLabel.layer.masksToBounds = YES;
//    self.todayLabel.layer.cornerRadius = 3;
//    self.lunarLabel.layer.masksToBounds = YES;
//    self.lunarLabel.layer.cornerRadius = 3;
//    self.festivalLabel.layer.masksToBounds = YES;
//    self.festivalLabel.layer.cornerRadius = 2;
    self.festivalLabel.edgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    
}

+ (instancetype)showCalendarContentView {
    return [[[NSBundle mainBundle] loadNibNamed:@"HLCalenderContentView" owner:nil options:nil]lastObject];
}

- (void)setModel:(HLCalendarModel *)model {
    _model = model;
    
    self.festivalLabel.textColor = [UIColor whiteColor];
    if (model.holiday) {
        self.festivalLabel.text = model.holiday;
    }else {
        self.festivalLabel.text = @"今天没有节日噢~";
    }
    
    
    NSString *dateString = [NSString stringWithFormat:@"%@ %@",model.date,model.weekday];
    self.dateLabel.text = dateString;
    
    NSString *lunarString = [NSString stringWithFormat:@"%@(%@年) %@",model.lunarYear,model.zodiac,model.lunar];
    self.lunarDetailLabel.text = lunarString;
    
    self.advisableLabel.text = model.avoid;
    
    self.suitableLable.text = model.suit;
    
}
@end
