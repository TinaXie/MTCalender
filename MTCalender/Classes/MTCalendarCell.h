//
//  MTCalendarCell.h
//  MTCalender
//
//  Created by Tina on 2019/3/23.
//  Copyright © 2019年 Tina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTCalendarMonthModel.h"


@interface MTCalendarCell : UICollectionViewCell

@property (nonatomic, strong) UIColor *defualtTextHighlightColor;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) MTCalendarDayModel *model;

- (void)isMark:(BOOL)isMark;
@end


