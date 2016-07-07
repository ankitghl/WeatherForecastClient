//
//  ATWeather.m
//
//  Created by Ankit Gohel on 29/06/16
//  Copyright (c) 2016 Netwin Infosolutions. All rights reserved.
//

#import "ATWeather.h"


NSString *const kATWeatherId = @"id";
NSString *const kATWeatherMain = @"main";
NSString *const kATWeatherIcon = @"icon";
NSString *const kATWeatherDescription = @"description";


@interface ATWeather ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ATWeather

@synthesize weatherIdentifier = _weatherIdentifier;
@synthesize main = _main;
@synthesize icon = _icon;
@synthesize weatherDescription = _weatherDescription;


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
            self.weatherIdentifier = [[self objectOrNilForKey:kATWeatherId fromDictionary:dict] doubleValue];
            self.main = [self objectOrNilForKey:kATWeatherMain fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kATWeatherIcon fromDictionary:dict];
            self.weatherDescription = [self objectOrNilForKey:kATWeatherDescription fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.weatherIdentifier] forKey:kATWeatherId];
    [mutableDict setValue:self.main forKey:kATWeatherMain];
    [mutableDict setValue:self.icon forKey:kATWeatherIcon];
    [mutableDict setValue:self.weatherDescription forKey:kATWeatherDescription];

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

    self.weatherIdentifier = [aDecoder decodeDoubleForKey:kATWeatherId];
    self.main = [aDecoder decodeObjectForKey:kATWeatherMain];
    self.icon = [aDecoder decodeObjectForKey:kATWeatherIcon];
    self.weatherDescription = [aDecoder decodeObjectForKey:kATWeatherDescription];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_weatherIdentifier forKey:kATWeatherId];
    [aCoder encodeObject:_main forKey:kATWeatherMain];
    [aCoder encodeObject:_icon forKey:kATWeatherIcon];
    [aCoder encodeObject:_weatherDescription forKey:kATWeatherDescription];
}

- (id)copyWithZone:(NSZone *)zone
{
    ATWeather *copy = [[ATWeather alloc] init];
    
    if (copy) {

        copy.weatherIdentifier = self.weatherIdentifier;
        copy.main = [self.main copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
        copy.weatherDescription = [self.weatherDescription copyWithZone:zone];
    }
    
    return copy;
}


@end
