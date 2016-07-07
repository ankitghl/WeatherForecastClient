//
//  ATCity.m
//
//  Created by Prateek Jain on 30/06/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ATCity.h"
#import "ATCoord.h"


NSString *const kATCityId = @"id";
NSString *const kATCityCoord = @"coord";
NSString *const kATCityCountry = @"country";
NSString *const kATCityName = @"name";
NSString *const kATCityPopulation = @"population";


@interface ATCity ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ATCity

@synthesize cityIdentifier = _cityIdentifier;
@synthesize coord = _coord;
@synthesize country = _country;
@synthesize name = _name;
@synthesize population = _population;


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
            self.cityIdentifier = [[self objectOrNilForKey:kATCityId fromDictionary:dict] doubleValue];
            self.coord = [ATCoord modelObjectWithDictionary:[dict objectForKey:kATCityCoord]];
            self.country = [self objectOrNilForKey:kATCityCountry fromDictionary:dict];
            self.name = [self objectOrNilForKey:kATCityName fromDictionary:dict];
            self.population = [[self objectOrNilForKey:kATCityPopulation fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityIdentifier] forKey:kATCityId];
    [mutableDict setValue:[self.coord dictionaryRepresentation] forKey:kATCityCoord];
    [mutableDict setValue:self.country forKey:kATCityCountry];
    [mutableDict setValue:self.name forKey:kATCityName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.population] forKey:kATCityPopulation];

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

    self.cityIdentifier = [aDecoder decodeDoubleForKey:kATCityId];
    self.coord = [aDecoder decodeObjectForKey:kATCityCoord];
    self.country = [aDecoder decodeObjectForKey:kATCityCountry];
    self.name = [aDecoder decodeObjectForKey:kATCityName];
    self.population = [aDecoder decodeDoubleForKey:kATCityPopulation];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_cityIdentifier forKey:kATCityId];
    [aCoder encodeObject:_coord forKey:kATCityCoord];
    [aCoder encodeObject:_country forKey:kATCityCountry];
    [aCoder encodeObject:_name forKey:kATCityName];
    [aCoder encodeDouble:_population forKey:kATCityPopulation];
}

- (id)copyWithZone:(NSZone *)zone
{
    ATCity *copy = [[ATCity alloc] init];
    
    if (copy) {

        copy.cityIdentifier = self.cityIdentifier;
        copy.coord = [self.coord copyWithZone:zone];
        copy.country = [self.country copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.population = self.population;
    }
    
    return copy;
}


@end
