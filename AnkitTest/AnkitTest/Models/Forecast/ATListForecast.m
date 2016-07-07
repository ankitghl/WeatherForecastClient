//
//  ATListForecast.m
//
//  Created by Prateek Jain on 30/06/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ATListForecast.h"
#import "ATTemp.h"
#import "ATWeather.h"


NSString *const kATListCloudsForecast = @"clouds";
NSString *const kATListHumidityForecast = @"humidity";
NSString *const kATListRainForecast= @"rain";
NSString *const kATListSpeedForecast = @"speed";
NSString *const kATListDtForecast = @"dt";
NSString *const kATListPressureForecast = @"pressure";
NSString *const kATListTempForecast = @"temp";
NSString *const kATListWeatherForecast = @"weather";
NSString *const kATListDegForecast = @"deg";


@interface ATListForecast ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ATListForecast

@synthesize clouds = _clouds;
@synthesize humidity = _humidity;
@synthesize rain = _rain;
@synthesize speed = _speed;
@synthesize dt = _dt;
@synthesize pressure = _pressure;
@synthesize temp = _temp;
@synthesize weather = _weather;
@synthesize deg = _deg;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.clouds = [[self objectOrNilForKey:kATListCloudsForecast fromDictionary:dict] doubleValue];
        self.humidity = [[self objectOrNilForKey:kATListHumidityForecast fromDictionary:dict] doubleValue];
        self.rain = [[self objectOrNilForKey:kATListRainForecast fromDictionary:dict] doubleValue];
        self.speed = [[self objectOrNilForKey:kATListSpeedForecast fromDictionary:dict] doubleValue];
        self.dt = [[self objectOrNilForKey:kATListDtForecast fromDictionary:dict] doubleValue];
        self.pressure = [[self objectOrNilForKey:kATListPressureForecast fromDictionary:dict] doubleValue];
        self.temp = [ATTemp modelObjectWithDictionary:[dict objectForKey:kATListTempForecast]];
        NSObject *receivedATWeather = [dict objectForKey:kATListWeatherForecast];
        NSMutableArray *parsedATWeather = [NSMutableArray array];
        if ([receivedATWeather isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedATWeather) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedATWeather addObject:[ATWeather modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedATWeather isKindOfClass:[NSDictionary class]]) {
            [parsedATWeather addObject:[ATWeather modelObjectWithDictionary:(NSDictionary *)receivedATWeather]];
        }
        
        self.weather = [NSArray arrayWithArray:parsedATWeather];
        self.deg = [[self objectOrNilForKey:kATListDegForecast fromDictionary:dict] doubleValue];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.clouds] forKey:kATListCloudsForecast];
    [mutableDict setValue:[NSNumber numberWithDouble:self.humidity] forKey:kATListHumidityForecast];
    [mutableDict setValue:[NSNumber numberWithDouble:self.rain] forKey:kATListRainForecast];
    [mutableDict setValue:[NSNumber numberWithDouble:self.speed] forKey:kATListSpeedForecast];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dt] forKey:kATListDtForecast];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pressure] forKey:kATListPressureForecast];
    [mutableDict setValue:[self.temp dictionaryRepresentation] forKey:kATListTempForecast];
    NSMutableArray *tempArrayForWeather = [NSMutableArray array];
    for (NSObject *subArrayObject in self.weather) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForWeather addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForWeather addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForWeather] forKey:kATListWeatherForecast];
    [mutableDict setValue:[NSNumber numberWithDouble:self.deg] forKey:kATListDegForecast];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.clouds = [aDecoder decodeDoubleForKey:kATListCloudsForecast];
    self.humidity = [aDecoder decodeDoubleForKey:kATListHumidityForecast];
    self.rain = [aDecoder decodeDoubleForKey:kATListRainForecast];
    self.speed = [aDecoder decodeDoubleForKey:kATListSpeedForecast];
    self.dt = [aDecoder decodeDoubleForKey:kATListDtForecast];
    self.pressure = [aDecoder decodeDoubleForKey:kATListPressureForecast];
    self.temp = [aDecoder decodeObjectForKey:kATListTempForecast];
    self.weather = [aDecoder decodeObjectForKey:kATListWeatherForecast];
    self.deg = [aDecoder decodeDoubleForKey:kATListDegForecast];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeDouble:_clouds forKey:kATListCloudsForecast];
    [aCoder encodeDouble:_humidity forKey:kATListHumidityForecast];
    [aCoder encodeDouble:_rain forKey:kATListRainForecast];
    [aCoder encodeDouble:_speed forKey:kATListSpeedForecast];
    [aCoder encodeDouble:_dt forKey:kATListDtForecast];
    [aCoder encodeDouble:_pressure forKey:kATListPressureForecast];
    [aCoder encodeObject:_temp forKey:kATListTempForecast];
    [aCoder encodeObject:_weather forKey:kATListWeatherForecast];
    [aCoder encodeDouble:_deg forKey:kATListDegForecast];
}

- (id)copyWithZone:(NSZone *)zone
{
    ATListForecast *copy = [[ATListForecast alloc] init];
    
    if (copy) {
        
        copy.clouds = self.clouds;
        copy.humidity = self.humidity;
        copy.rain = self.rain;
        copy.speed = self.speed;
        copy.dt = self.dt;
        copy.pressure = self.pressure;
        copy.temp = [self.temp copyWithZone:zone];
        copy.weather = [self.weather copyWithZone:zone];
        copy.deg = self.deg;
    }
    
    return copy;
}


@end
