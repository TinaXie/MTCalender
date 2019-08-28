//
//  MTCalendarHeader.m
//  MTCalender
//
//  Created by Tina on 2019/3/23.
//  Copyright © 2019年 Tina. All rights reserved.
//

#import "MTCalendarHeader.h"
#import "MTBundleUtils.h"
#import "UIImage+MTCalender.h"

@interface MTCalendarHeader ()

@end

@implementation MTCalendarHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.backButton = [[UIButton alloc] init];
    self.backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIImage *backImg = [MTBundleUtils imageWithName:@"mt_calendar_back"];
    UIImage *backImg_normal = [backImg tintColor:[UIColor blackColor]];
    UIImage *backImg_highlight = [backImg tintColor:[UIColor blueColor]];

    [self.backButton setImage:backImg_normal forState:UIControlStateNormal];
    [self.backButton setImage:backImg_highlight forState:UIControlStateHighlighted];
    [self addSubview:self.backButton];

    self.forwardButton = [[UIButton alloc] init];
    self.forwardButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    UIImage *forwardImg = [MTBundleUtils imageWithName:@"mt_calendar_forward"];
    UIImage *forwardImg_normal = [forwardImg tintColor:[UIColor blackColor]];
    UIImage *forwardImg_highlight = [forwardImg tintColor:[UIColor blueColor]];

    [self.forwardButton setImage:forwardImg_normal forState:UIControlStateNormal];
    [self.forwardButton setImage:forwardImg_highlight forState:UIControlStateHighlighted];
    [self addSubview:self.forwardButton];

    self.dateButton = [[UIButton alloc] init];
    [self.dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.dateButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    [self addSubview:self.dateButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat edgeOffset = 40.0;
    CGFloat buttonW = 24.0;
    CGFloat buttonH = buttonW;

    self.dateButton.center = self.center;
    self.dateButton.frame = CGRectMake(self.dateButton.frame.origin.x,
                                       self.dateButton.frame.origin.y,
                                       self.frame.size.width * 0.5,
                                       buttonH);
    self.backButton.frame = CGRectMake(edgeOffset, (self.frame.size.height - buttonH) * 0.5, buttonW, buttonH);

    self.forwardButton.frame = CGRectMake(self.frame.size.width - edgeOffset - buttonW,
                                          (self.frame.size.height - buttonH) * 0.5,
                                          buttonW,
                                          buttonH);
}


@end
