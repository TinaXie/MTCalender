//
//  UIImage+MTCalender.h
//  MTCalender
//
//  Created by Tina on 2019/3/23.
//  Copyright © 2019年 Tina. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (MTCalender)

+ (UIImage *)mt_getImage:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;

- (UIImage *)tintColor:(UIColor *)tintColor;

@end

