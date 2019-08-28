//
//  MTCalendarCell.m
//  MTCalender
//
//  Created by Tina on 2019/3/23.
//  Copyright © 2019年 Tina. All rights reserved.
//

#import "MTCalendarCell.h"
#import "UIImage+MTCalender.h"
#import "UILabel+MTCalender.h"
#import "MTBundleUtils.h"

@interface MTCalendarCell ()

@property (nonatomic, strong) UIImageView *markImg;


@end

@implementation MTCalendarCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.defualtTextHighlightColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:1 alpha:1];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"12";
    [self addSubview:self.titleLabel];

    UIImage *mark = [MTBundleUtils imageWithName:@"mt_calender_mark"];
    self.markImg = [[UIImageView alloc] initWithImage:mark];
    self.markImg.hidden = YES;
    self.markImg.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.markImg];
}

- (void)setModel:(MTCalendarDayModel *)model {
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"%ld", model.day];

    // if is today
    if (model.isToday) {
        self.titleLabel.textColor = self.defualtTextHighlightColor;
        self.titleLabel.backgroundColor = [UIColor lightGrayColor];
        [self.titleLabel mt_setWithCornerRadius:17.0];
        [self addAnimation];
    } else {
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.titleLabel mt_resetCornerRadius];

        switch(model.dayTag) {
        case MTDayTag_currentMonth:
            {
                self.titleLabel.textColor = [UIColor blackColor];
            }
                break;
        default:
            {
                self.titleLabel.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
            }
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(CGRectGetMidX(self.bounds) - 17,
                                       CGRectGetMidY(self.bounds) - 17,
                                       34, 34);

    CGFloat markW = CGRectGetWidth(self.titleLabel.frame);
    CGFloat markH = 10.0;
    self.markImg.frame = CGRectMake(CGRectGetMidX(self.bounds) - markW * 0.5,
                                    CGRectGetMaxY(self.bounds) - markH - 4,
                                    markW, markH);

}

- (void) addAnimation {
    CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
    animation.keyPath = @"transform.scale";
    animation.calculationMode = kCAAnimationPaced;
    animation.duration = 0.25;
    [self.titleLabel.layer addAnimation:animation forKey:nil];
}

- (void)isMark:(BOOL)isMark {
    self.markImg.hidden = !isMark;
}

@end

