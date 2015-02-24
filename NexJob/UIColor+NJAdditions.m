//
//  UIColor+NJAdditions.m
//  NexJob
//
//  Created by KP on 2/21/15.
//  Copyright (c) 2015 War of the Totems. All rights reserved.
//

#import "UIColor+NJAdditions.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIColor (NJAdditions)

+ (UIColor*)nj_redColor
{
    return UIColorFromRGB(0xEB413E);
}

+ (UIColor*)nj_greyColor
{
    return UIColorFromRGB(0xEEEEEE);
}

@end
