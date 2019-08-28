//
//  MTCalendarView.m
//  MTCalender
//
//  Created by Tina on 2019/3/24.
//  Copyright © 2019年 Tina. All rights reserved.
//

#import "MTCalendarView.h"
#import "MTCalendarCell.h"
#import "NSDate+MTCalender.h"

#define MTCalendarCellIdentifier @"MTCalendarCell"

@interface MTCalendarView ()
<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) MTCalendarMonthModel *currentMonthData;
@property (nonatomic, strong) MTCalendarHeader *calendarHeaderView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *calenderCollectionView;

@property (nonatomic, strong) NSArray *weekTitles;
@property (nonatomic, strong) NSMutableArray<MTCalendarMonthModel *> *calendarMonthDataArr;

@end

@implementation MTCalendarView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.weekTitles = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
        self.calendarMonthDataArr = [NSMutableArray array];
        [self initView];
    }
    return self;
}

- (void)initView {
    self.calendarHeaderView = [[MTCalendarHeader alloc] initWithFrame:CGRectZero];
    [self.calendarHeaderView.backButton addTarget:self action:@selector(goToPreMonth) forControlEvents:UIControlEventTouchUpInside];
    [self.calendarHeaderView.forwardButton addTarget:self action:@selector(goToNextMonth) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.calendarHeaderView];

    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;

    self.calenderCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    self.calenderCollectionView.delegate = self;
    self.calenderCollectionView.dataSource = self;
    self.calenderCollectionView.backgroundColor = [UIColor clearColor];
    self.calenderCollectionView.alwaysBounceVertical = NO;
    self.calenderCollectionView.showsVerticalScrollIndicator = NO;
    self.calenderCollectionView.showsHorizontalScrollIndicator = NO;

    // register collectionview cell
    Class cellClass = [MTCalendarCell class];
    [self.calenderCollectionView registerClass:cellClass forCellWithReuseIdentifier:MTCalendarCellIdentifier];
    [self addSubview:self.calenderCollectionView];

    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goToNextMonth)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;

    // add swipe gesture
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goToPreMonth)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.calenderCollectionView addGestureRecognizer:leftSwipe];
    [self.calenderCollectionView addGestureRecognizer:rightSwipe];
    [self setupInitialization];
}


- (void)setupInitialization {
    NSDate *currentDate = [NSDate date];
    self.currentMonthData = [MTCalendarMonthModel modelWithDate:currentDate];
}

- (void)setCurrentMonthData:(MTCalendarMonthModel *)currentMonthData {
    _currentMonthData = currentMonthData;

    [self.calendarMonthDataArr removeAllObjects];

    NSDate *currentDate = currentMonthData.date;
    NSDate *preDate = currentDate.mt_previousMonthDate;
    NSDate *nextDate = currentDate.mt_nextMonthDate;


    MTCalendarMonthModel *previousMonthModel = [MTCalendarMonthModel modelWithDate:preDate];
    MTCalendarMonthModel *nextMonthModel = [MTCalendarMonthModel modelWithDate:nextDate];

    [self.calendarMonthDataArr addObject:previousMonthModel];
    [self.calendarMonthDataArr addObject:currentMonthData];
    [self.calendarMonthDataArr addObject:nextMonthModel];

    NSString *headerTitle = [NSString stringWithFormat:@"%ld年%ld月", (long)self.currentMonthData.year, (long)self.currentMonthData.month];
    [self.calendarHeaderView.dateButton setTitle:headerTitle forState:UIControlStateNormal];
}

- (void)setMarkList:(NSArray<NSDate *> *)markList {
    _markList = markList;
    [self reloadData];
}

- (void)reloadData {
    [self.calenderCollectionView reloadData];
}

- (void)goToToday {
    NSDate *oldDate = self.currentMonthData.date;
    [self setupInitialization];
    if (self.currentMonthData) {
        NSDate *nowDate = self.currentMonthData.date;
        BOOL isSameMoth = (nowDate.mt_year == oldDate.mt_year) && (nowDate.mt_month == oldDate.mt_month);
        if (!isSameMoth) {
            BOOL isAfter = [nowDate timeIntervalSinceDate:oldDate] > 0.0;
            if (isAfter) {
                [self performSwipeAnimation:kCATransitionFromRight];
            } else {
                [self performSwipeAnimation:kCATransitionFromLeft];
            }
        }
    }
    [self.calenderCollectionView reloadData];

}

//下一个月
- (void)goToNextMonth {
    NSInteger usedIndex = [self monthIndexOf:self.currentMonthData];
    NSInteger nextIndex = usedIndex + 1;
    if (usedIndex < 0 || nextIndex >= self.calendarMonthDataArr.count) {
        NSLog(@"下一个月 没有了。。。");
        return;
    }

    self.currentMonthData = self.calendarMonthDataArr[nextIndex];
    [self performSwipeAnimation:kCATransitionFromRight];
    [self.calenderCollectionView reloadData];
}


//上一个月
- (void)goToPreMonth {
    NSInteger usedIndex = [self monthIndexOf:self.currentMonthData];
    NSInteger preIndex = usedIndex - 1;
    if (preIndex < 0) {
        return;
    }

    self.currentMonthData = self.calendarMonthDataArr[preIndex];
    [self performSwipeAnimation:kCATransitionFromLeft];
    [self.calenderCollectionView reloadData];
}


/// get the current index of target obj in calendarMonthDataArr
///
/// - Parameter model: target object
/// - Returns: --
-(NSInteger) monthIndexOf:(MTCalendarMonthModel *)model {
    NSInteger index = -1;
    for (NSInteger i=0; i<self.calendarMonthDataArr.count; i++) {
        MTCalendarMonthModel *m = [self.calendarMonthDataArr objectAtIndex:i];
        if (model.date == m.date) {
            index = i;
            break;
        }
    }
    return index;
}

-(void)performSwipeAnimation:(CATransitionSubtype)subType {
    CATransition *transition = [[CATransition alloc] init];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = subType;
    [self.calenderCollectionView.layer addAnimation:transition forKey:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.calendarHeaderView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 64.0);
    self.calenderCollectionView.frame  = CGRectMake(20,
                                                    CGRectGetMaxY(self.calendarHeaderView.frame),
                                                    CGRectGetWidth(self.frame) - 40.0,
                                                    CGRectGetHeight(self.frame) - CGRectGetHeight(self.calendarHeaderView.frame) - 10);
}

#pragma mark - delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = self.currentMonthData.dayArr.count + self.weekTitles.count;
    return count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MTCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MTCalendarCellIdentifier forIndexPath:indexPath];
    //标题栏
    if (indexPath.row < self.weekTitles.count) {
        cell.titleLabel.text = self.weekTitles[indexPath.row];
        cell.titleLabel.textColor = [UIColor blueColor];
        cell.titleLabel.backgroundColor = [UIColor clearColor];
    } else {
        //日期时间
        NSInteger index = indexPath.row - self.weekTitles.count;
        if (index < self.currentMonthData.dayArr.count) {
            MTCalendarDayModel *model = self.currentMonthData.dayArr[index];
            cell.model = model;
            [cell isMark:[self isMarkModel:model]];
        }
    }
    return cell;
}

- (BOOL)isMarkModel:(MTCalendarDayModel *)model {
    BOOL isMark = NO;
    for (NSDate *date in self.markList) {
        if (self.currentMonthData.year == date.mt_year &&
            self.currentMonthData.month == date.mt_month &&
            model.day == date.mt_day) {
            isMark = YES;
            break;
        }
    }
    return isMark;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize;
    CGFloat itemW = CGRectGetWidth(self.calenderCollectionView.frame) / self.weekTitles.count;
    NSInteger rowNums = self.weekTitles.count;
    if (self.currentMonthData.dayArr.count > 0) {
        rowNums = (self.currentMonthData.dayArr.count / self.weekTitles.count) + 1;
    }

    itemSize = CGSizeMake(itemW, CGRectGetHeight(self.calenderCollectionView.frame) / rowNums);
    return itemSize;
}


@end

