//
//  AppDelegate.h
//  AnkitTest
//
//  Created by Ankit Gohel on 27/06/16.
//  Copyright © 2016 Ankit Gohel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATWeatherClient.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;

/**
 *  Object of Weather API Class to be used in app for getting API response
 */
@property(strong, nonatomic) ATWeatherClient *weatherAPI;

/**
 *
 *
 *  @return To get Instance of Appdelegate
 */
+ (AppDelegate *)appDelegate;

@end

