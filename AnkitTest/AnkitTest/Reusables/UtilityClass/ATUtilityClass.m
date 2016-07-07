//
//  ATUtilityClass.m
//  AnkitTest
//
//  Created by Ankit on 01/07/16.
//  Copyright © 2016 Ankit Gohel. All rights reserved.
//

#import "ATUtilityClass.h"

@implementation ATUtilityClass

/**
 *  Converts timestamp to Date string
 *
 *  @param timestamp Timestamp to be converted
 *
 *  @return Date String
 */

+(NSString *)getDateStringFromTimestamp:(double)timestamp
{
    NSString *dateComponents = @"H:m dMMMMyyyy";
    NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:dateComponents options:0 locale:[NSLocale systemLocale]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *strDate = [dateFormatter stringFromDate:date];
    
    return strDate;
}

/**
 *  Returns current Theme color
 *
 *  @return Theme Color
 */

+(UIColor *)getThemeColor
{
    return  [UIColor colorWithRed:17.0f / 255.0f green:171.0f / 255.0f blue:231.0f / 255.0f alpha:1.0f];
}
@end
