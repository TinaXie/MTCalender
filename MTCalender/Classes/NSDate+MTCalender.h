//
//  NSDate+MTCalender.h
//  MTCalender
//
//  Created by Tina on 2019/3/23.
//  Copyright © 2019年 Tina. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (MTCalender)

- (NSDate *)mt_previousDate;

- (NSDate *)mt_nextDate;

- (NSDate *)mt_previousMonthDate;

- (NSDate *)mt_nextMonthDate;

- (NSInteger)mt_daysInMonth;

- (NSInteger)mt_firstWeekDayInMonth;

- (NSInteger)mt_year;

- (NSInteger)mt_month;

- (NSInteger)mt_day;

@end

