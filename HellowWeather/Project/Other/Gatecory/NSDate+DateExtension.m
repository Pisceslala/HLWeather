//
//  NSDate+DateExtension.m
//  SweetCandy
//
//  Created by Pisces on 2016/11/25.
//  Copyright © 2016年 Pisces. All rights reserved.
//

#import "NSDate+DateExtension.h"

@implementation NSDate (DateExtension)

- (BOOL)isToday {
    
    NSDate *now = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    [fmt setDateFormat:@"yyyy-mm--dd"];
    
    NSString *creatString = [fmt stringFromDate:self];
    
    NSString *nowString = [fmt stringFromDate:now];

    return [nowString isEqualToString:creatString];
}

- (BOOL)isYesterday {
    
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *compareComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self toDate:now options:0];
    
    return compareComp.year == 0 && compareComp.month == 0 && compareComp.day == 1 ;
}

- (BOOL)isThisYears {
    
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *creat = [calendar components:NSCalendarUnitYear fromDate:self];
    
    NSDateComponents *nowcoms = [calendar components:NSCalendarUnitYear fromDate:now];
    
    return creat.year == nowcoms.year;
    
}

+ (NSString *)dateWithtimeStamp:(NSString *)timeStringStamp {
    
    NSTimeInterval timeSta = [timeStringStamp doubleValue];
    
    NSDateFormatter *fmat = [[NSDateFormatter alloc] init];
    
    fmat.dateStyle = NSDateFormatterShortStyle;
    
    fmat.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSta];
    
    NSString *dateString = [fmat stringFromDate:date];
    
    return dateString;
    
}

@end
