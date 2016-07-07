//
//  ATWeatherClient.m
//  AnkitTest
//
//  Created by Ankit Gohel on 28/06/16.
//  Copyright © 2016 Ankit Gohel. All rights reserved.
//

#import "ATWeatherClient.h"


@interface ATWeatherClient ()
{
    NSString *_baseURL;
    NSString *_apiKey;
    NSString *_apiVersion;
    NSOperationQueue *_weatherQueue;
    
    NSString *_lang;
    
    ATProgressLoaderViewController *vcProgress;
}

@end

@implementation ATWeatherClient

- (instancetype) initWithAPIKey:(NSString *) apiKey
{
    self = [super init];
    if (self) {
        _baseURL = @"http://api.openweathermap.org/data/";
        _apiKey  = apiKey;
        _apiVersion = @"2.5";
        
        _weatherQueue = [[NSOperationQueue alloc] init];
        _weatherQueue.name = @"ATWeatherQueue";
        
    }
    return self;
}

/// Initialise and Load Session Manager
-(NSURLSession *)loadSessionManager
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        
    return session;
    
}


- (void) callMethod:(NSString *) method
          onSuccess:(OnSuccessCompletionHandler)success
          onFailure:(OnFailureCompletionHandler)failure
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@&APPID=%@", _baseURL, _apiVersion, method, _apiKey];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];

    NSURL *url = [NSURL URLWithString:urlString];
    
    vcProgress = [[ATProgressLoaderViewController alloc] initWithNibName:@"ATProgressLoaderViewController" bundle:nil];
    [vcProgress.view setFrame:[[UIApplication sharedApplication] keyWindow].frame];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIApplication sharedApplication] keyWindow] addSubview:vcProgress.view];

    });
    
    [[[self loadSessionManager] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        if (!error) {
            // Success
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                if (jsonError)
                {
                    // Error Parsing JSON
                    failure(jsonError);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [vcProgress.view removeFromSuperview];

                    });

                }
                else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"%@",jsonResponse);
                    success(jsonResponse);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [vcProgress.view removeFromSuperview];

                    });
                }
            }
            else {
                //Web server is returning an error
                NSError *error = [NSError errorWithDomain:@"Webservice Reponse Error" code:420 userInfo:@{NSLocalizedDescriptionKey:@"error"}];

                failure(error);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [vcProgress.view removeFromSuperview];
                });


            }
        }
        else {
            // Fail
            failure(error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [vcProgress.view removeFromSuperview];

            });


        }

    }] resume];
}


-(void) currentWeatherByCityName:(NSString *) name
                     withSuccess:(OnSuccessCompletionHandler)success
                       orFailure:(OnFailureCompletionHandler)failure

{
    
    NSString *method = [NSString stringWithFormat:@"/weather?q=%@&units=metric", name];
    [self callMethod:method onSuccess:success onFailure:failure];
}


-(void) currentWeatherByCoordinate:(CLLocationCoordinate2D) coordinate
                       withSuccess:(OnSuccessCompletionHandler)success
                         orFailure:(OnFailureCompletionHandler)failure
{
    
    NSString *method = [NSString stringWithFormat:@"/weather?lat=%f&lon=%f&units=metric",
                        coordinate.latitude, coordinate.longitude ];
    [self callMethod:method onSuccess:success onFailure:failure];
}



-(void) dailyForecastWeatherByCityName:(NSString *) name
                           withCount:(int) count
                         withSuccess:(OnSuccessCompletionHandler)success
                           orFailure:(OnFailureCompletionHandler)failure
{
    NSString *method = [NSString stringWithFormat:@"/forecast/daily?q=%@&cnt=%d&units=metric", name, count];
    [self callMethod:method onSuccess:success onFailure:failure];
}

-(void) dailyForecastWeatherByCoordinate:(CLLocationCoordinate2D) coordinate
                               withCount:(int) count
                             withSuccess:(OnSuccessCompletionHandler)success
                               orFailure:(OnFailureCompletionHandler)failure
{
    
    NSString *method = [NSString stringWithFormat:@"/forecast/daily?lat=%f&lon=%f&cnt=%d&units=metric",
                        coordinate.latitude, coordinate.longitude, count ];
    [self callMethod:method onSuccess:success onFailure:failure];
    
}

-(void) findForecastWeatherByCoordinate:(CLLocationCoordinate2D) coordinate
                               withCount:(int) count
                             withSuccess:(OnSuccessCompletionHandler)success
                               orFailure:(OnFailureCompletionHandler)failure
{
    
    NSString *method = [NSString stringWithFormat:@"/find?lat=%f&lon=%f&cnt=%d",
                        coordinate.latitude, coordinate.longitude, count ];
    [self callMethod:method onSuccess:success onFailure:failure];
    
}
@end
