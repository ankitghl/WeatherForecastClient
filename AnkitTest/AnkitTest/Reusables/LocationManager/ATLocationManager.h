//
//  ATLocationManager.h
//  AnkitTest
//
//  Created by Ankit Gohel on 29/06/16.
//  Copyright © 2016 Ankit Gohel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 Checks if the Location is to saved for fetching near by city of for current weather
 */
typedef enum
{
    kForNearByCities = 1,
    kForCurrentLocation
} kLocationTag;

@protocol ATLocationManager <NSObject>

@optional
/**
 *  Get current location and sends it as delegate
 *
 *  @param location Locatoin fetched
 *  @param kTag     kLocationTag type check
 */
-(void)getCurrentLocation:(CLLocation *)location forTag:(kLocationTag)kTag;


@end

@interface ATLocationManager : NSObject<CLLocationManagerDelegate>

/**
 *  Location Manager to get location service working
 */
@property(strong,nonatomic) CLLocationManager *locationManager;
/**
 *  Stores current location of user
 */
@property(nonatomic,strong)CLLocation *locCurrent;
/**
 *  gets/sets location tag
 */
@property(nonatomic)kLocationTag locationTag;
/**
 *  Delegate for getting llocation
 */
@property (weak,nonatomic) id <ATLocationManager> delegate;


@end
