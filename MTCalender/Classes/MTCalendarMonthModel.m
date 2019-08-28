//
//  MTCalendarMonthModel.m
//  MTCalender
//
//  Created by Tina on 2019/3/23.
//  Copyright © 2019年 Tina. All rights reserved.
//

#import "MTCalendarMonthModel.h"
#import "NSDate+MTCalender.h"

@implementation MTCalendarDayModel

@end

@implementation MTCalendarMonthModel

+ (instancetype)modelWithDate:(NSDate *)date {
    MTCalendarMonthModel *model = [[MTCalendarMonthModel alloc] init];
    model.date = date;
    return model;
}

- (instancetype)init {
    if (self = [super init]) {
        self.dayArr = [NSMutableArray array];
    }
    return self;
}

- (void)setDate:(NSDate *)date {
    _date = date;

    NSDate *priviousDate = [date mt_previousMonthDate];
    if (priviousDate == nil) {
        return;
    }

    self.totalDays = date.mt_daysInMonth;
    self.firstWeakdays = date.mt_firstWeekDayInMonth;
    self.year = date.mt_year;
    self.month = date.mt_month;
    [self.dayArr removeAllObjects];

    NSInteger totalNums = self.totalDays + self.firstWeakdays;
    totalNums = (totalNums % 7) == 0 ? totalNums : (totalNums + 7 - (totalNums % 7));
    for (NSInteger i=0; i<totalNums; i++) {
        MTCalendarDayModel *model = [[MTCalendarDayModel alloc] init];

        // if is pervious days
        if (i < self.firstWeakdays) {
            model.day = priviousDate.mt_daysInMonth - (self.firstWeakdays - i) + 1;
            model.dayTag = MTDayTag_perviousMonth;
        } else if (i >= self.firstWeakdays + self.totalDays) {
            // next month days
            model.day = i - self.totalDays - self.firstWeakdays + 1;
            model.dayTag = MTDayTag_nextMonth;
        } else {
            // current month days
            model.day = i - self.firstWeakdays + 1;
            model.dayTag = MTDayTag_currentMonth;
            NSDate *currentDate = [NSDate date];
            // current day
            if (self.month == currentDate.mt_month &&
                self.year == currentDate.mt_year &&
                i == currentDate.mt_day + self.firstWeakdays - 1) {
                model.isToday = YES;
            }
        }
        [self.dayArr addObject:model];
    }

}

@end
