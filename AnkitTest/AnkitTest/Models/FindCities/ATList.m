//
//  ATList.m
//
//  Created by Ankit Gohel on 29/06/16
//  Copyright (c) 2016 Netwin Infosolutions. All rights reserved.
//

#import "ATList.h"
#import "ATWind.h"
#import "ATRain.h"
#import "ATCoord.h"
#import "ATClouds.h"
#import "ATMain.h"
#import "ATWeather.h"
#import "ATSys.h"


NSString *const kATListWind = @"wind";
NSString *const kATListRain = @"rain";
NSString *const kATListDt = @"dt";
NSString *const kATListId = @"id";
NSString *const kATListCoord = @"coord";
NSString *const kATListClouds = @"clouds";
NSString *const kATListMain = @"main";
NSString *const kATListWeather = @"weather";
NSString *const kATListSys = @"sys";
NSString *const kATListName = @"name";


@interface ATList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ATList

@synthesize wind = _wind;
@synthesize rain = _rain;
@synthesize dt = _dt;
@synthesize listIdentifier = _listIdentifier;
@synthesize coord = _coord;
@synthesize clouds = _clouds;
@synthesize main = _main;
@synthesize weather = _weather;
@synthesize sys = _sys;
@synthesize name = _name;


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
            self.wind = [ATWind modelObjectWithDictionary:[dict objectForKey:kATListWind]];
            self.rain = [ATRain modelObjectWithDictionary:[dict objectForKey:kATListRain]];
            self.dt = [[self objectOrNilForKey:kATListDt fromDictionary:dict] doubleValue];
            self.listIdentifier = [[self objectOrNilForKey:kATListId fromDictionary:dict] doubleValue];
            self.coord = [ATCoord modelObjectWithDictionary:[dict objectForKey:kATListCoord]];
            self.clouds = [ATClouds modelObjectWithDictionary:[dict objectForKey:kATListClouds]];
            self.main = [ATMain modelObjectWithDictionary:[dict objectForKey:kATListMain]];
    NSObject *receivedATWeather = [dict objectForKey:kATListWeather];
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
            self.sys = [ATSys modelObjectWithDictionary:[dict objectForKey:kATListSys]];
            self.name = [self objectOrNilForKey:kATListName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.wind dictionaryRepresentation] forKey:kATListWind];
    [mutableDict setValue:[self.rain dictionaryRepresentation] forKey:kATListRain];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dt] forKey:kATListDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.listIdentifier] forKey:kATListId];
    [mutableDict setValue:[self.coord dictionaryRepresentation] forKey:kATListCoord];
    [mutableDict setValue:[self.clouds dictionaryRepresentation] forKey:kATListClouds];
    [mutableDict setValue:[self.main dictionaryRepresentation] forKey:kATListMain];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForWeather] forKey:kATListWeather];
    [mutableDict setValue:[self.sys dictionaryRepresentation] forKey:kATListSys];
    [mutableDict setValue:self.name forKey:kATListName];

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

    self.wind = [aDecoder decodeObjectForKey:kATListWind];
    self.rain = [aDecoder decodeObjectForKey:kATListRain];
    self.dt = [aDecoder decodeDoubleForKey:kATListDt];
    self.listIdentifier = [aDecoder decodeDoubleForKey:kATListId];
    self.coord = [aDecoder decodeObjectForKey:kATListCoord];
    self.clouds = [aDecoder decodeObjectForKey:kATListClouds];
    self.main = [aDecoder decodeObjectForKey:kATListMain];
    self.weather = [aDecoder decodeObjectForKey:kATListWeather];
    self.sys = [aDecoder decodeObjectForKey:kATListSys];
    self.name = [aDecoder decodeObjectForKey:kATListName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_wind forKey:kATListWind];
    [aCoder encodeObject:_rain forKey:kATListRain];
    [aCoder encodeDouble:_dt forKey:kATListDt];
    [aCoder encodeDouble:_listIdentifier forKey:kATListId];
    [aCoder encodeObject:_coord forKey:kATListCoord];
    [aCoder encodeObject:_clouds forKey:kATListClouds];
    [aCoder encodeObject:_main forKey:kATListMain];
    [aCoder encodeObject:_weather forKey:kATListWeather];
    [aCoder encodeObject:_sys forKey:kATListSys];
    [aCoder encodeObject:_name forKey:kATListName];
}

- (id)copyWithZone:(NSZone *)zone
{
    ATList *copy = [[ATList alloc] init];
    
    if (copy) {

        copy.wind = [self.wind copyWithZone:zone];
        copy.rain = [self.rain copyWithZone:zone];
        copy.dt = self.dt;
        copy.listIdentifier = self.listIdentifier;
        copy.coord = [self.coord copyWithZone:zone];
        copy.clouds = [self.clouds copyWithZone:zone];
        copy.main = [self.main copyWithZone:zone];
        copy.weather = [self.weather copyWithZone:zone];
        copy.sys = [self.sys copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
