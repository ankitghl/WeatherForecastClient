//
//  AppDelegate.m
//  AnkitTest
//
//  Created by Ankit Gohel on 27/06/16.
//  Copyright © 2016 Ankit Gohel. All rights reserved.
//

#import "AppDelegate.h"
#import "ATUtilityClass.h"

//http://openweathermap.org/img/w/10n.png

static NSString *strAPIKEY = @"593c9b02b9e7cc2d5502efec953962a8";

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize weatherAPI;


#pragma mark - AppDelegate Life Cycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Set API key For OpenWeather API
    weatherAPI = [[ATWeatherClient alloc] initWithAPIKey:strAPIKEY];

    // Customises Navigation bar
    [self customiseNavigationBar];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


#pragma mark - Private Methods

/**
 *  Customise Navigaton for BG color and text color
 */
- (void)customiseNavigationBar {
    [UINavigationBar appearance].barTintColor = [ATUtilityClass getThemeColor];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].translucent = NO;
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];

}
@end
