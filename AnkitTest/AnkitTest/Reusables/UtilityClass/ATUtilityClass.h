//
//  ATUtilityClass.h
//  AnkitTest
//
//  Created by Ankit on 01/07/16.
//  Copyright © 2016 Ankit Gohel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ATUtilityClass : NSObject


/**
 *  Converts timestamp to Date string
 *
 *  @param timestamp Timestamp to be converted
 *
 *  @return Date String
 */
+(NSString *)getDateStringFromTimestamp:(double)timestamp;


/**
 *  Returns current Theme color
 *
 *  @return Theme Color
 */
+(UIColor *)getThemeColor;

@end
