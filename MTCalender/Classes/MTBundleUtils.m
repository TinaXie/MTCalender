//
//  MTBundleUtils.m
//  MTCalender
//
//  Created by Tina on 2019/3/23.
//  Copyright © 2019年 Tina. All rights reserved.
//

#import "MTBundleUtils.h"

@implementation MTBundleUtils

+ (NSBundle *)currBundler {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MTCalender" ofType:@"bundle"];
    if (path == nil) {
        return nil;
    }
    NSBundle *bundle = [[NSBundle alloc] initWithPath:path];
    return bundle;
}

+ (UIImage *)imageWithName:(NSString *)name {
    NSBundle *bundle = [MTBundleUtils currBundler];
    NSString *type = @"png";
    NSString *scale = @"@2x";
    if ([UIScreen mainScreen].scale == 3.0) {
        scale = @"@3x";
    }
    name = [name stringByAppendingString:scale];
    NSString *path = [bundle pathForResource:name ofType:type];
    if (path == nil) {
        return nil;
    }
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    return img;
}

@end
