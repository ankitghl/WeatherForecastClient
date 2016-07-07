//
//  ATMain.m
//
//  Created by Ankit Gohel on 29/06/16
//  Copyright (c) 2016 Netwin Infosolutions. All rights reserved.
//

#import "ATMain.h"


NSString *const kATMainHumidity = @"humidity";
NSString *const kATMainTempMin = @"temp_min";
NSString *const kATMainTempMax = @"temp_max";
NSString *const kATMainTemp = @"temp";
NSString *const kATMainPressure = @"pressure";
NSString *const kATMainGrndLevel = @"grnd_level";
NSString *const kATMainSeaLevel = @"sea_level";


@interface ATMain ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ATMain

@synthesize humidity = _humidity;
@synthesize tempMin = _tempMin;
@synthesize tempMax = _tempMax;
@synthesize temp = _temp;
@synthesize pressure = _pressure;
@synthesize grndLevel = _grndLevel;
@synthesize seaLevel = _seaLevel;


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
            self.humidity = [[self objectOrNilForKey:kATMainHumidity fromDictionary:dict] doubleValue];
            self.tempMin = [[self objectOrNilForKey:kATMainTempMin fromDictionary:dict] doubleValue];
            self.tempMax = [[self objectOrNilForKey:kATMainTempMax fromDictionary:dict] doubleValue];
            self.temp = [[self objectOrNilForKey:kATMainTemp fromDictionary:dict] doubleValue];
            self.pressure = [[self objectOrNilForKey:kATMainPressure fromDictionary:dict] doubleValue];
            self.grndLevel = [[self objectOrNilForKey:kATMainGrndLevel fromDictionary:dict] doubleValue];
            self.seaLevel = [[self objectOrNilForKey:kATMainSeaLevel fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.humidity] forKey:kATMainHumidity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tempMin] forKey:kATMainTempMin];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tempMax] forKey:kATMainTempMax];
    [mutableDict setValue:[NSNumber numberWithDouble:self.temp] forKey:kATMainTemp];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pressure] forKey:kATMainPressure];
    [mutableDict setValue:[NSNumber numberWithDouble:self.grndLevel] forKey:kATMainGrndLevel];
    [mutableDict setValue:[NSNumber numberWithDouble:self.seaLevel] forKey:kATMainSeaLevel];

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

    self.humidity = [aDecoder decodeDoubleForKey:kATMainHumidity];
    self.tempMin = [aDecoder decodeDoubleForKey:kATMainTempMin];
    self.tempMax = [aDecoder decodeDoubleForKey:kATMainTempMax];
    self.temp = [aDecoder decodeDoubleForKey:kATMainTemp];
    self.pressure = [aDecoder decodeDoubleForKey:kATMainPressure];
    self.grndLevel = [aDecoder decodeDoubleForKey:kATMainGrndLevel];
    self.seaLevel = [aDecoder decodeDoubleForKey:kATMainSeaLevel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_humidity forKey:kATMainHumidity];
    [aCoder encodeDouble:_tempMin forKey:kATMainTempMin];
    [aCoder encodeDouble:_tempMax forKey:kATMainTempMax];
    [aCoder encodeDouble:_temp forKey:kATMainTemp];
    [aCoder encodeDouble:_pressure forKey:kATMainPressure];
    [aCoder encodeDouble:_grndLevel forKey:kATMainGrndLevel];
    [aCoder encodeDouble:_seaLevel forKey:kATMainSeaLevel];
}

- (id)copyWithZone:(NSZone *)zone
{
    ATMain *copy = [[ATMain alloc] init];
    
    if (copy) {

        copy.humidity = self.humidity;
        copy.tempMin = self.tempMin;
        copy.tempMax = self.tempMax;
        copy.temp = self.temp;
        copy.pressure = self.pressure;
        copy.grndLevel = self.grndLevel;
        copy.seaLevel = self.seaLevel;
    }
    
    return copy;
}


@end
