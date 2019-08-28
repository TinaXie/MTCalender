//
//  NSDate+MTCalender.m
//  MTCalender
//
//  Created by Tina on 2019/3/23.
//  Copyright © 2019年 Tina. All rights reserved.
//

#import "NSDate+MTCalender.h"

@implementation NSDate (MTCalender)

- (NSDate *)mt_previousDate {
     NSDate *preDate = [[NSDate alloc]initWithTimeIntervalSinceReferenceDate:([self timeIntervalSinceReferenceDate] - 24 * 3600)];
    return preDate;
}

- (NSDate *)mt_nextDate {
    NSDate *nextDate = [[NSDate alloc]initWithTimeIntervalSinceReferenceDate:([self timeIntervalSinceReferenceDate] + 24 * 3600)];
    return nextDate;
}

- (NSDate *)mt_previousMonthDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    components.day = 15;
    if (components.month == 1) {
        components.month = 12;
        components.year -= 1;
    } else {
        components.month -= 1;
    }

    NSDate *result = [calendar dateFromComponents:components];
    return result;
}


- (NSDate *)mt_nextMonthDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];

    if (components.month == 12) {
        components.month = 1;
        components.year += 1;
    } else {
        components.month += 1;
    }

    NSDate *result = [calendar dateFromComponents:components];
    return result;
}

- (NSInteger)mt_daysInMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return range.length;
}

- (NSInteger)mt_firstWeekDayInMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];

    components.day = 1;
    NSDate *firstDay = [calendar dateFromComponents:components];
    if (firstDay == nil) {
        return 1;
    }
    NSInteger num = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDay];
    NSInteger result = num - 1;
    return result;
}

- (NSInteger)mt_year {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:self];
    NSInteger result = components.year;
    return result;
}

- (NSInteger)mt_month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:self];
    NSInteger result = components.month;
    return result;
}

- (NSInteger)mt_day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:self];
    NSInteger result = components.day;
    return result;
}


@end
