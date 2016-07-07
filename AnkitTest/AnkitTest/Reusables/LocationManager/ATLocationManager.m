//
//  ATLocationManager.m
//  AnkitTest
//
//  Created by Ankit Gohel on 29/06/16.
//  Copyright © 2016 Ankit Gohel. All rights reserved.
//

#import "ATLocationManager.h"
#import <UIKit/UIKit.h>

@implementation ATLocationManager
@synthesize locationManager;
@synthesize delegate;

#pragma mark - Init Method
/**
 *  Initilaise Location Manager
 *
 *  @return Instance
 */
- (id)init
{
    if (self = [super init])
    {
        [self requestAlwaysAuthorization];
    }
    return self;
}

#pragma mark - Location Manager Delegates

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *currentLocation = [locations objectAtIndex:0];
    
    self.locCurrent = currentLocation;
    
    [locationManager stopUpdatingLocation];
    
    if ([delegate respondsToSelector:@selector(getCurrentLocation:forTag:)]) {
        [delegate getCurrentLocation:currentLocation forTag:self.locationTag];
    }

}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",error.localizedDescription);
}

#pragma mark - Private Methods

/**
 *   Request permission for getiing location from user
 */
- (void)requestAlwaysAuthorization
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    // If the status is denied or only granted for when in use, display an alert
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusDenied) {
        NSString *title;
        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
        NSString *message = @"To use background location you must turn on 'Always' in the Location Services Settings";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Settings", nil];
        [alertView show];
    }
    else
    {
        if ([CLLocationManager locationServicesEnabled]) {

        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = 10;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [locationManager requestAlwaysAuthorization];
        }
    
        [locationManager startUpdatingLocation];
        }
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // Send the user to the Settings for this app
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }
}


@end
