//
//  MTCalendarMonthModel.h
//  MTCalender
//
//  Created by Tina on 2019/3/23.
//  Copyright © 2019年 Tina. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MTCalndarWeek_sunday     = 0,
    MTCalndarWeek_monday     = 1,
    MTCalndarWeek_thuesday   = 2,
    MTCalndarWeek_wednesday  = 3,
    MTCalndarWeek_thursday   = 4,
    MTCalndarWeek_friday     = 5,
    MTCalndarWeek_saturday   = 6,
} MTCalndarWeek;

typedef enum {
    MTDayTag_currentMonth   = 0,
    MTDayTag_perviousMonth  = 1,
    MTDayTag_nextMonth      = 2,
} MTDayTag;

@interface MTCalendarDayModel : NSObject

@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) MTDayTag dayTag;
@property (nonatomic, assign) BOOL isToday;
@property (nonatomic, assign) BOOL isSelected;

@end

@interface MTCalendarMonthModel : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) NSInteger totalDays;
@property (nonatomic, assign) NSInteger firstWeakdays;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, strong) NSMutableArray<MTCalendarDayModel *> *dayArr;

+ (instancetype)modelWithDate:(NSDate *)date;

@end


