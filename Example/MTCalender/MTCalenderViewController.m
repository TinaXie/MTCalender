//
//  MTCalenderViewController.m
//  MTCalender
//
//  Created by xiejc on 03/25/2019.
//  Copyright (c) 2019 xiejc. All rights reserved.
//

#import "MTCalenderViewController.h"
#import "MTCalender.h"

@interface MTCalenderViewController ()

@property (nonatomic, strong) MTCalendarView *calendarView;

@property (nonatomic, strong) UIButton *todayBtn;

@end

@implementation MTCalenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    CGRect viewFrame = CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 313.0);
    self.calendarView = [[MTCalendarView alloc] initWithFrame:viewFrame];
    [self.view addSubview:self.calendarView];
    
    self.calendarView.markList = [self markList];
    
    self.todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.todayBtn.frame = CGRectMake(100, 400, 60, 40);
    self.todayBtn.backgroundColor = [UIColor grayColor];
    [self.todayBtn addTarget:self
                      action:@selector(gotoToday) forControlEvents:UIControlEventTouchUpInside];
    [self.todayBtn setTitle:@"today" forState:UIControlStateNormal];
    [self.view addSubview:self.todayBtn];
}

- (void)gotoToday {
    [self.calendarView goToToday];
}

- (NSArray *)markList {
    NSDate *currentDate = [NSDate date];
    NSDate *d1 = [currentDate mt_previousMonthDate];
    NSDate *d2 = [currentDate mt_nextMonthDate];
    
    NSDate *d3 = [currentDate mt_previousDate];
    NSDate *d4 = [currentDate mt_nextDate];
    return @[d1, d2, d3, d4];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

@end
