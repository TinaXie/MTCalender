//
//  MTCalendarView.h
//  MTCalender
//
//  Created by Tina on 2019/3/24.
//  Copyright © 2019年 Tina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTCalendarMonthModel.h"
#import "MTCalendarHeader.h"


@interface MTCalendarView : UIView

@property (nonatomic, strong) NSArray<NSDate *> *markList;

- (void)goToToday;

@end

