//
//  ATWeatherClient.h
//  AnkitTest
//
//  Created by Ankit Gohel on 28/06/16.
//  Copyright © 2016 Ankit Gohel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "ATProgressLoaderViewController.h"


/**
 *   Success handler on API succes response
 *
 *  @param receivedString Response from API
 */
typedef void (^OnSuccessCompletionHandler)(id receivedString);

/**
 *   Failure handler on API succes response
 *
 *  @param error
 */
typedef void (^OnFailureCompletionHandler)(NSError *error);


@interface ATWeatherClient : NSObject

/**
 *  Success callback on API response
 */
@property (nonatomic,strong) OnSuccessCompletionHandler successHandler;
/**
 *  Failure callback on API response
 */
@property (nonatomic,strong) OnFailureCompletionHandler failureHandler;


/**
 *  Initalise class
 *
 *  @param apiKey current API key to be used
 *
 *  @return instance type
 */
- (instancetype) initWithAPIKey:(NSString *) apiKey;


/**
 *  fetched records for current weather for city and returns success/failure
 *
 *  @param name    City Name
 *  @param success Success Hanler
 *  @param failure Failure Handler
 */
-(void) currentWeatherByCityName:(NSString *) name
                     withSuccess:(OnSuccessCompletionHandler)success
                       orFailure:(OnFailureCompletionHandler)failure;


/**
 *  fetched records for current weather for lcoation and returns success/failure
 *
 *  @param coordinate Location Coordinate
 *  @param success Success Hanler
 *  @param failure Failure Handler
 */

-(void) currentWeatherByCoordinate:(CLLocationCoordinate2D) coordinate
                       withSuccess:(OnSuccessCompletionHandler)success
                         orFailure:(OnFailureCompletionHandler)failure;

/**
 *  fetched forecasts for current weather for lcoation and returns success/failure
 *
 *  @param coordinate Location Coordinate
 *  @param count      number of days for which the data is to be fetched
 *  @param success Success Hanler
 *  @param failure Failure Handler
 */
-(void) dailyForecastWeatherByCoordinate:(CLLocationCoordinate2D) coordinate
                               withCount:(int) count
                             withSuccess:(OnSuccessCompletionHandler)success
                               orFailure:(OnFailureCompletionHandler)failure;


/**
 *  fetched forecasts for current weather for lcoation and returns success/failure
 *
 *  @param name    City Name
 *  @param count      number of days for which the data is to be fetched
 *  @param success Success Hanler
 *  @param failure Failure Handler
 */
-(void) dailyForecastWeatherByCityName:(NSString *) name
                             withCount:(int) count
                           withSuccess:(OnSuccessCompletionHandler)success
                             orFailure:(OnFailureCompletionHandler)failure;

-(void) findForecastWeatherByCoordinate:(CLLocationCoordinate2D) coordinate
                              withCount:(int) count
                            withSuccess:(OnSuccessCompletionHandler)success
                              orFailure:(OnFailureCompletionHandler)failure;


@end
